<?php
header("Content-Type: text/plain");
$curl = curl_init();

curl_setopt_array($curl, array(
    CURLOPT_RETURNTRANSFER => 1,
    CURLOPT_URL => 'api'
));

$result = curl_exec($curl);

echo "Super Website Homepage" . PHP_EOL;
echo "The api says: " . $result . PHP_EOL;
?>