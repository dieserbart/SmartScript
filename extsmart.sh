#!/usr/local/bin/sh
#
# ra01 is the machine to check (passed parameter)
ra01=$1

# This will use the characters after "/dev/" for the temp file names.
# Example: /dev/ada0 becomes coverada0 or cover0ada0 or cover1ada0
# This needs to be done to keep multiple jobs from using the same files.
drv=`echo ${ra01} | cut -c6-`

# Variable just so we can add a note that the drive was asleep when the
# application started but is now awake.
c=0

### Run SMART Quick Test
runsmartshort()
{
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sda #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdb #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdc #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdd #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sde #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdf #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdg #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdh #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdi #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdj #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdk #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
### If changing to long SMART test, swap the hash marks from the three lines below.
### You may edit the sleep to whatever your drive recommends for the test to finish.
smartctl -t short /dev/sdl #${ra01}
# smartctl -t long ${switch1}
echo "Short Test Running, waiting 5 minutes for test to finish."
# echo "Long Test Running, waiting 255 minutes for test to finish."
sleep 300
# sleep 15300
}

### Process to run our check on the drive, setup exclusivly for only "-l error". 
# Output cover0
chkdrive()
{
smartctl -n standby -l error -l selftest /dev/sda > /var/cover0${drv}
smartctl -n standby -l error -l selftest /dev/sdb > /var/cover2${drv}
smartctl -n standby -l error -l selftest /dev/sdc > /var/cover4${drv}
smartctl -n standby -l error -l selftest /dev/sdd > /var/cover6${drv}
smartctl -n standby -l error -l selftest /dev/sde > /var/cover8${drv}
smartctl -n standby -l error -l selftest /dev/sdf > /var/cover10${drv}
smartctl -n standby -l error -l selftest /dev/sdg > /var/cover12${drv}
smartctl -n standby -l error -l selftest /dev/sdh > /var/cover14${drv}
smartctl -n standby -l error -l selftest /dev/sdi > /var/cover16${drv}
smartctl -n standby -l error -l selftest /dev/sdj > /var/cover18${drv}
smartctl -n standby -l error -l selftest /dev/sdk > /var/cover20${drv}
smartctl -n standby -l error -l selftest /dev/sdl > /var/cover22${drv}
}

### Process to create the email header
# Input cover1, output cover.
makeheader()
{
(
echo "To: gleichy@gmx.net"
printf "Subject: SMART Drive Results for ${ra01} - " ; cat /var/cover1${drv}
echo " "
) > /var/cover${drv}
}

### Process to create the email header for failure
# Input none, output cover.
makeheaderfailure()
{
(
echo "To: gleichy@gmx.net"
printf "Subject: SMART Drive Results for ${ra01} - PROBLEM" 
echo " "
) > /var/cover${drv}
}

### Process for normal results
# Input is cover0, output is cover1
procnormal()
{
### Delete lines 1 through 5 leaving the status returned, cover0 cannot be changed here.
sed '1,5d' /var/cover0${drv} > /var/cover1${drv}
sed '1,5d' /var/cover2${drv} > /var/cover3${drv}
sed '1,5d' /var/cover4${drv} > /var/cover5${drv}
sed '1,5d' /var/cover6${drv} > /var/cover7${drv}
sed '1,5d' /var/cover8${drv} > /var/cover9${drv}
sed '1,5d' /var/cover10${drv} > /var/cover11${drv}
sed '1,5d' /var/cover12${drv} > /var/cover13${drv}
sed '1,5d' /var/cover14${drv} > /var/cover15${drv}
sed '1,5d' /var/cover16${drv} > /var/cover17${drv}
sed '1,5d' /var/cover18${drv} > /var/cover19${drv}
sed '1,5d' /var/cover20${drv} > /var/cover21${drv}
sed '1,5d' /var/cover22${drv} > /var/cover23${drv}

### If the drive was asleep we can add a line so the user knows it was sleeping
if [ $c -eq 1 ]
then
(
echo " "
date
printf "The drive was sleeping and just woke up."
echo " "
) >> /var/cover1${drv}
fi
}

# Process to cleanup our trash files
cleanup()
{
rm /var/cover${drv}
rm /var/cover0${drv}
rm /var/cover1${drv}
rm /var/cover2${drv}
rm /var/cover3${drv}
rm /var/cover4${drv}
rm /var/cover5${drv}
rm /var/cover6${drv}
rm /var/cover7${drv}
rm /var/cover8${drv}
rm /var/cover9${drv}
rm /var/cover10${drv}
rm /var/cover11${drv}
rm /var/cover12${drv}
rm /var/cover13${drv}
rm /var/cover14${drv}
rm /var/cover15${drv}
rm /var/cover16${drv}
rm /var/cover17${drv}
rm /var/cover18${drv}
rm /var/cover19${drv}
rm /var/cover20${drv}
rm /var/cover21${drv}
rm /var/cover22${drv}
rm /var/cover23${drv}
}

### Lets test the drive
runsmartshort

### Lets call chkdrive, output is cover0
chkdrive
### If chkdrive returns a value 2 for sleeping then loop
while [ $? -eq "2" ]
do
### Pause the checking of the drive to about once a minute if the drive is not running.
### This can be changed to more or less frequent, it's a personal choice.
sleep 59
c=1
chkdrive
done

### If chkdrive returns a value other than 0 before or after sleeping, error.
if [ $? -ne "0" ]
then
makeheaderfailure
cat /var/cover0${drv} >> /var/cover1${drv}
cat /var/cover2${drv} >> /var/cover3${drv}
cat /var/cover4${drv} >> /var/cover5${drv}
cat /var/cover6${drv} >> /var/cover7${drv}
cat /var/cover8${drv} >> /var/cover9${drv}
cat /var/cover10${drv} >> /var/cover11${drv}
cat /var/cover12${drv} >> /var/cover13${drv}
cat /var/cover14${drv} >> /var/cover15${drv}
cat /var/cover16${drv} >> /var/cover17${drv}
cat /var/cover18${drv} >> /var/cover19${drv}
cat /var/cover20${drv} >> /var/cover21${drv}
cat /var/cover22${drv} >> /var/cover23${drv}
else
procnormal

### Chop off all but the most recent 5 test results
sed '11,40d' /var/cover${drv} > /var/cover1${drv}
fi

ssmtp -t < /var/cover1${drv}

### Call Cleanup Process
cleanup
exit 0


 < /var/cover1${drv}

### Call Cleanup Process
cleanup
exit 0


#Example of the output. I have it set to give you the last 5 tests vice all tests.


#From: root@freenas.local
#To: youremail@address.net
#Subject: SMART Drive Results for /dev/ada0 - No Errors Logged
#
#SMART Self-test log structure revision number 1
#Num Test_Description Status Remaining LifeTime(hours) LBA_of_first_error
# 1 Short offline Completed without error 00% 2646 -
# 2 Extended offline Completed without error 00% 2400 -
# 3 Short offline Completed without error 00% 2168 -
# 4 Extended offline Completed without error 00% 2002 -
# 5 Extended offline Completed without error 00% 1936 -
