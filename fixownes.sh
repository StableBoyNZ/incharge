#!/bin/bash

##################################################
# This BashScript is to "restore" home directories
# created when users logon. Authentications 'SSSD'.
# Directories have same name as user logon IDs.
# However changes in UserNames or when users depart
# the Organisation leaves the directory in an:
# 'orpahned' state,
# with a 'UID Number' as the Ownder,
# instead of the Logon ID of the user.
# This script is to loop through all of them,
# and basically use the directory's name itself
# to be used as the ownership of the directory.
# Group however seems to say okay i.e. gidNumber 1000,
# or "Domain Users".
nameofdir=""
logFile="ownershipsfix.log"
logDir=""
####################################################

# Change into new directory
cd /home/

# Generate new file list, manipulate and save
echo `date +%F` >> $logFile 
ls -l > 
sudo -u root obnam ls>"obnamhome-ls-$(date +%Y-%m-%d).txt"

sudo -u boudiccas obnam --config=/etc/obnam-back4.conf ls>"obnamback4-ls-$(date +%Y-%m-%d).txt"

obnam --config=/etc/obnametc.conf ls>"obnametc-ls-$(date +%Y-%m-%d).txt"

obnam --config=/etc/obnamusr.conf ls>"obnamusr-ls-$(date +%Y-%m-%d).txt"

obnam --config=/etc/obnamvar.conf ls>"obnamvar-ls-$(date +%Y-%m-%d).txt"

# Delete old backups!
find /home/boudiccas/cron/obnam -type f -mtime +$NUM -name 'obnamhome-ls-*.txt' -exec rm -v {} + >>$LOGFILE 2>&1

find /home/boudiccas/cron/obnam -type f -mtime +$NUM -name 'obnamback4-ls-*.txt' -exec rm -v {} + >>$LOGFILE 2>&1

find /home/boudiccas/cron/obnam -type f -mtime +$NUM -name 'obnametc-ls-*.txt' -exec rm -v {} + >>$LOGFILE 2>&1

find /home/boudiccas/cron/obnam -type f -mtime +$NUM -name 'obnamusr-ls-*.txt' -exec rm -v {} + >>$LOGFILE 2>&1

find /home/boudiccas/cron/obnam -type f -mtime +$NUM -name 'obnamvar-ls-*.txt' -exec rm -v {} + >>$LOGFILE 2>&1
########################################################################
