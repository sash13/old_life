<?php
$content = '?????? #404996';
list($test, $out) = split('[#.-]', $content);
//echo $out;
$fp = fopen("data/test.txt","w+");
fwrite($fp, $out);
fclose($fp);



$filename = "data/test.txt";
$handle = fopen($filename, "r");
$contents = fread($handle, filesize($filename));
echo $contents.'  for test';
fclose($handle);
?>