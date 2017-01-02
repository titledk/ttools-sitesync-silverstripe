#!/bin/bash
#This script overwrites the current site
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

ENVVARS="$BASEDIR/ttools/core/lib/vars-for-env.sh $ENV"
eval `$ENVVARS`


echo "Importing database...";

#echo "php path is $ENV_PHPPATH";

CMD="$ENV_PHPPATH $MODULEDIR/lib/php/import-db.php $DBNAME $ENV_PHPPATH"
echo "executing: $CMD"
$CMD


echo "Importing files...";

FILES_TO_IMPORT=$FILESDIR/public/assets/;


rsync -avz --delete $FILES_TO_IMPORT $SILVERSTRIPE_PATH/assets;



