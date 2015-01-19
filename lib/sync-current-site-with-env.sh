#!/bin/bash
#This script syncs the current site to/from a specified environment
#Run like this: sync-current-site-with-env.sh to Dev


#Sync direction
if [ -z "${1}" ]; then
	echo "Please specify sync direction: \"to\" or \"from\"";
	exit;
fi
SYNCDIRECTION=$1

#Environment
if [ -z "${2}" ]; then
	echo "Please specify environment";
	exit;
fi
ENV=$2

if [[ "$ENV" == "Live" ]] && [[ "$SYNCDIRECTION" == "to" ]]; then
	echo "You are not allowed to sync to Live. Exiting.";
	echo "Note: if this is for your first deployment, uncomment this line.";
	exit;
fi


BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../.. && pwd )";
MODULEDIR="$BASEDIR/ttools/sitesync-silverstripe";

ENVVARS="$BASEDIR/ttools/core/lib/vars-for-env.sh $ENV"
eval `$ENVVARS`




#Overwrite remote with current
if [[ "$SYNCDIRECTION" == "to" ]]; then
	
	echo "Now Pushing Your Database & Assets to your $ENV environment...";
	
	echo "Dumping site...";
	$BASEDIR/ttools/sitesync-core/lib/dump-current-site.sh dump;
	
	
	echo "Now syncing files up to the $ENV environment...";
	$BASEDIR/ttools/sitesync-core/lib/sync-dump-to-env.sh $ENV;
	
	
	echo "Connecting with $ENV for import";
	#On the server we'll be doing the following
	
	#Loading db and files from the dump we just uploaded into the site
	SERVER_OVERWRITE_CMD="$ENV_REPODIR/ttools/sitesync-core/lib/overwrite-current-site.sh $ENV";
	SERVER_COMMANDS="$SERVER_OVERWRITE_CMD;";
	
	#echo $SERVER_COMMANDS;
	
	ssh $ENV_CUSTOM_SSHCONNECTIONSTR -t $SERVER_COMMANDS 

fi




#Overwrite current with remote
if [[ "$SYNCDIRECTION" == "from" ]]; then

	echo "Now Overwriting Current Site with Database & Assets from $ENV environment...";
	
	echo "Dumping site on $ENV...";
	SERVER_COMMANDS="$ENV_REPODIR/ttools/sitesync-core/lib/dump-current-site.sh dump $ENV;";
	ssh $ENV_CUSTOM_SSHCONNECTIONSTR -t $SERVER_COMMANDS;
	
	
	echo "Downloading dump...";
	$BASEDIR/ttools/sitesync-core/lib/sync-dump-from-env.sh $ENV;
	
	
	echo "Overwriting current site...";
	$BASEDIR/ttools/sitesync-core/lib/overwrite-current-site.sh;

fi
