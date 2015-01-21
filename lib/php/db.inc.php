<?php
/**
 * Include for SilverStripe database cred sniffing
 * Needed both for databse import and database export
 */
$dbname = null;

//expecting database name & php path

//db name
if (isset($argv[1])) {
	$dbname = $argv[1];
} else {
	echo "You need to supply a database name \n";
	return;
}
//php path
if (isset($argv[2])) {
	$phppath = $argv[2];
} else {
	echo "You need to supply the php path \n";
	return;
}



$repoDir = dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/';

$sniffer = $repoDir . 'ttools/thirdparty/sspak/src/sspak-sniffer.php';
$output = shell_exec("$phppath $sniffer {$repoDir}public");

$parsed = @unserialize($output);
//var_dump($parsed);
