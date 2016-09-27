#!/bin/bash
#This script dumps the current site
#Called from sitesync/core
#Needs to be supplied with db name, files dir, and environment

DBNAME=$1
FILESDIR=$2
ENV=$3


#echo "Supplied variables:";
#echo "DB: $DBNAME";
#echo "Files: $FILESDIR";
#echo "Env: $ENV";



BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../.. && pwd )";
MODULEDIR="$BASEDIR/ttools/sitesync-silverstripe";
SILVERSTRIPE_PATH="$BASEDIR/public";
FILES_PATHS="$SILVERSTRIPE_PATH/assets"; #this can be one or more paths, separated with spaces


source $BASEDIR/ttools/core/lib/inc.sh;

ENVVARS="$BASEDIR/ttools/core/lib/vars-for-env.sh $ENV"
eval `$ENVVARS`



echo "Dumping database...";

echo "DEBUG: " $ENV_PHPPATH $MODULEDIR/lib/php/export-db.php $DBNAME $ENV_PHPPATH
$ENV_PHPPATH $MODULEDIR/lib/php/export-db.php $DBNAME $ENV_PHPPATH


echo "Dumping files...";

#rewriting files dir a little to make sure
#they are saved relative to the repo root
FILESDIR="$FILESDIR/public";
mkdir -p $FILESDIR;




rsyncV=$(rsync --version | egrep -o "([0-9]{1,}\.)+[0-9]{1,}");

echo "rsync version: $rsyncV";

vercomp "$rsyncV" "3.0.9"
output=$?;
if [[ $output = 1 ]] 
then
	echo "rsync version is 3.1.0 or larger - using progress2"
	rsync -az --delete --info=progress2 $FILES_PATHS $FILESDIR;
else
	echo "rsync version is smaller than 3.1.0 - using verbose mode"
	rsync -avz --delete $FILES_PATHS $FILESDIR;
fi




