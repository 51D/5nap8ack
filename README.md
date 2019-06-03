# [5nap_8ack]
###### Created by 51D
## A simple tool for creating backups/snapshots of files or partitions. 
#### It is currently written for bash specifically, I'm working on getting it ported over to python soon to deal with some interoperability issues.
##### To download and run the script simply paste the commands below in any terminal. I would suggest running the script as root to make sure you don't have any errors due to insufficient file permissions.
```
git clone https://github.com/51D/5nap8ack.git 
cd 5nap*
./5nap*
```
#### You will then be asked what directory you like to create a snapshot of.
##### Make sure you leave a trailing "/" at the end of the filepath this time. If you forget to add the "/" the script will append it for you.

```
This is a generic script for automating backsups or pseudo-snapshots.
Verifying configuration directory...
Type the directory you want to create a snapshot of. eg. /home/
```
```
/home/user/Important_Files/
```

#### Next prompt you will need to supply a destination for the script to save the snapshots in.
##### This time do NOT leave a trailing "/" at the end of the path, just like before the script will remove any "/" and the end though.
```
Please be sure use complete filepaths. eg. /home/user/backups
/snapshots
```
##### It will then ask if this is the first time running the script for the selected files.
```
Is this the first commit? Type 'Y' or 'N' and then [ENTER].
Y
17825 (process ID) old priority 0, new priority 12
```
##### Here you will be asked if you have sufficient permissions to complete the snapshot.
```
Do you have permissions to write inside /snapshots? 
total 8
drwxr-xr-x  2 root root 4096 Jun  2 13:06 .
drwxr-xr-x 21 root root 4096 Jun  2 13:06 ..
Type 'Y' or 'N' and then [ENTER]
Y
```
##### If everything is correct the snapshot will be running and it will display the location of the currect job's log file. You can copy and paste the command from prompt to view the progress of the current job.
```
Rsync has started check the progress with tail -f...
tail -f /snapshots/home/user/Important_Files/rsync.log
```
