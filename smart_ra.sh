#!/usr/local/bin/sh
#
# Start smartctl every week at 5am
0 5 * * 1 /usr/sbin/smartctl -t long
#

radio=$1
(
echo "To: YourEmail@Address.net"
echo "Subject: SMART Drive Results for ${radio}"
echo " "
) > /var/cover
smartctl -i -H -A -n standby -l error ${radio} >> /var/cover
ssmtp -t < /var/cover
exit 0

# Set idle mode to so it doesn't spin up.
# Options -n standby = Will not let the drive spin up if it's not currently spinning. This means that no data will be present if the drive is not running because it exits out with an error condition. This is nice for those folks who like to use HDD Standby in FreeNAS.
# -i = Device Info (Does not force a drive spinup)
# -H = Device Health (Forces spinup)
# -A = Only Vendor specific SMART attributes (Forces spinup)
# -l error = SMART Error Log (Forces spinup)