<?php
/**
 * Importing the database
 * Expects database name
 */

include_once "db.inc.php";


$dbCmd = "mysql --user={$parsed['db_username']} --password='{$parsed['db_password']}' -h {$parsed['db_server']} -D {$parsed['db_database']} < {$dbname} --default_character_set utf8";


//echo $dbCmd;
shell_exec($dbCmd);

echo "DB synced \n";





