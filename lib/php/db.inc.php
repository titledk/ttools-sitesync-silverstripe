<?php
/**
 * Include for SilverStripe database cred sniffing
 * Needed both for databse import and database export
 */
$dbname = null;

//expecting database name
if (isset($argv[1])) {
	$dbname = $argv[1];
} else {
	echo "You need to supply a database name \n";
	return;
}


$repoDir = dirname(dirname(dirname(dirname(dirname(__FILE__))))) . '/';

$sniffer = $repoDir . 'ttools/thirdparty/sspak/src/sspak-sniffer.php';
$output = shell_exec("php $sniffer {$repoDir}public");

$parsed = @unserialize($output);
//var_dump($parsed);
