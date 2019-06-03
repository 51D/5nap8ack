# 5nap8ack
#### A simple tool for creating backups/snapshots of files or partitions. It is currently written for bash specifically,\n I'm working on getting it ported over to python soon to deal with some interoperability issues.
##### To download and run the script simply paste the commands below in any terminal. I would suggest running the script as root to make sure you don't have any errors due to insufficient file permissions.
```
git clone https://github.com/51D/5nap8ack.git 
cd 5nap*
./5nap*
```
#### You will then be asked what directory you like to create a snapshot of
##### make sure you leave a trailing "/" at the end of the filepath. If you forget to add the "/" the script will append it for you.

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
