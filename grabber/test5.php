<?php
$filename = "1.txt";
$handle = fopen($filename, "r");
$contents = fread($handle, filesize($filename));

//$simple = "<para><note>simple note</note></para>";
$p = xml_parser_create();
xml_parse_into_struct($p, $contents, $vals, $index);
xml_parser_free($p);
//echo "Index array\n";
//print_r($index);
echo "\nVals array\n";
print_r($vals);

fclose($handle);
?>
