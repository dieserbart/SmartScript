#!/usr/local/bin/sh
# Start smartctl every week at 5am
#0 5 * * 1 /usr/sbin/smartctl -t long
#
# Place this in /conf/base/etc/
# Call: sh esmart.sh /dev/ada0
# radio is the drive to check (passed parameter)
radio=$1

# This will use the characters after "/dev/" for the temp file names.
# Example: /dev/ada0 becomes coverada0 or cover0ada0 or cover1ada0
# This needs to be done to keep multiple jobs from using the same files.
drv=`echo $radio | cut -c6-`

# Variable just so we can add a note that the drive was asleep when the
# application started but is now awake.
c=0

# Process to run our check on the drive
chkdrive()
{
smartctl -H -n standby -l error ${radio} > /var/cover0${drv}
}

(
echo "To: sebastian.gleicher@gmail.com,atlas_admin@aei.mpg.de"
echo "Subject: SMART Drive Results for ${switch1}"
echo " "
) > /var/cover${drv}
chkdrive
while [ $? != "0" ]
do
# Pause the checking of the drive to about once a minute if the drive is not running.
sleep 59
c=1
chkdrive
done

if [ $c -eq 1 ]
then
echo "THE DRIVE WAS ASLEEP AND JUST WOKE UP" >> /var/cover${drv}
fi

# These lines remove the automatic Branding lines
sed -e '1d' /var/cover0${drv} > /var/cover1${drv}
sed -e '1d' /var/cover1${drv} > /var/cover0${drv}
sed -e '1d' /var/cover0${drv} > /var/cover1${drv}
sed -e '1d' /var/cover1${drv} > /var/cover0${drv}

cat /var/cover0${drv} >> /var/cover${drv}
ssmtp -t < /var/cover${drv}

# Cleanup our trash
rm /var/cover${drv}
rm /var/cover0${drv}
rm /var/cover1${drv}
exit 0

# Set idle mode to so it doesn't spin up.
# Options
# -n standby (Remove this to force a spinup)
# -i = Device Info
# -H = Device Health
# -A = Only Vendor specific SMART attributes
# -l error = SMART Error Log