<?php
/**
 * Exporting the database
 * Expects database name
 */

include_once "db.inc.php";


$socketInfo = null;
//if ($this->isMamp) {
//	$socketInfo = ' --socket ' . '/Applications/MAMP/tmp/mysql/mysql.sock';
//}


$cmd = 'mysqldump -u'
	. $parsed['db_username']
	. $socketInfo
	. ' -p' . escapeshellarg($parsed['db_password'])
	. ' -h ' . $parsed['db_server']
	. ' ' . $parsed['db_database']
	. ' > ' . $dbname;

//running dump
exec($cmd);



