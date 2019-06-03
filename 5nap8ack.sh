#!/bin/bash
#set -x #DEBUG
#PS4='$LINENO: ' #PRINT LINE NUMBERS
#5nap8ack the no bullshit backup utility. Pardon the code it sloppy as shit right now.

# config vars
echo "This is a generic script for automating backsups or pseudo-snapshots."
echo "Verifying configuration directory..."

if [[ ! -e $HOME/.snapshots ]]
then
	echo "Creating config directory in $HOME/.snapshots"
	mkdir $HOME/.snapshots
fi

echo "Type the directory you want to create a snapshot of. eg. "/home/""
read SRC
sleep .5

if [[ ! $SRC == */ ]]
then
	echo "Directory must end with a forward slash. eg. "/home/" "
	sleep .5
	echo "Appending..."
	SRC1="$SRC/"
	SRC=$SRC1
fi

sleep .5
echo "Where is the snapshop going to be saved?"
echo "Please be sure use complete filepaths. eg. /home/user/backups"
read DB
sleep .5

if [[ ! $DB == /* ]]
then
	echo "Invalid/Incomplete filepath, cannot continue."
	exit 1
fi

if [[ $DB == */ ]]
then
	echo "Detected a trailing "/"... "
	echo "Removing... "
	sleep .5
	echo $DB | awk '{$0=substr($0,1,length($0)-1); print $0}' > $HOME/.snapshots/tmp.txt
	DB1=$(cat $HOME/.snapshots/tmp.txt)
	sleep .5
	DB=$DB1
	rm $HOME/.snapshots/tmp.txt
fi

sleep .5
echo "Is this the first commit? Type 'Y' or 'N' and then [ENTER]."
read QTN
LOG="rsync.log"
SNAP="$DB$SRC"
OPTS="-rltgoi --delay-updates --delete --chmod=a-w"
MINCHANGES=20  #How many new lines in log file before creating a new a snapshot
sleep .5
ionice -c 3 -p $$
renice +12  -p $$
sleep .5

if [ $QTN == Y ]
then
	echo "Do you have permissions to write inside $DB? "
	ls -al $DB
	echo "Type 'Y' or 'N' and then [ENTER]"
	read WRT
fi

sleep .5

if [[ $WRT == N ]]
then
	sudo chown -R $USER:$GROUPS $DB
fi

sleep .5

if [[ ! -e $SNAP  ]]
	then
		echo="Creating directories for initial snapshot"
		mkdir -p $SNAP
fi

sleep .5
echo "Rsync has started check the progress with tail -f..."
echo "tail -f $SNAP$LOG"
rsync $OPTS $SRC $SNAP\latest >> $SNAP\rsync.log
sleep .5
COUNT=$( wc -l $SNAP\rsync.log|cut -d" " -f1 )
DATETAG=$(date +%Y-%m-%d)
FULLPATH="$SNAP$DATETAG"
sleep .5

if [[ $COUNT -gt $MINCHANGE ]]
	then
	echo "Archiving previous snapshot."
	cp -al $SNAP\latest $FULLPATH
  chmod u+w $FULLPATH
  mv $SNAP\rsync.log $FULLPATH
 	chmod u-w $FULLPATH
fi

sleep .5

if [[ $COUNT -lt $MINCHANGE ]]
	then
	echo "Previous snapshot is still up to date. Exiting..."
	exit 1
fi

sleep .5

echo "Snapshot maintainence complete."
sleep .5
echo "Saving variables for later use in $HOME/.snapshots/$SRC.."
sleep .5

if [[ ! -e "$HOME/.snapshots/$DATETAG" ]]
then
	echo $SRC >> $HOME/.snapshots/$SRC.$DATETAG.vars
	echo $DB >> $HOME/.snapshots/$SRC.$DATETAG.vars
	echo $DATETAG >> $HOME/.snapshots/$SRC.$DATETAG.vars
	echo $FULLPATH >> $HOME/.snapshots/$SRC.$DATETAG.vars
	echo $OPTS >> $HOME/.snapshots/$SRC.$DATETAG.vars
echo $SNAP >> $HOME/.snapshots/$SRC.$DATETAG.vars
fi

sleep .5

echo "Press [ENTER] to exit."
read
exit
