<html>
<head>
<title> Current SitePoint Articles </title>
</head>
<body>
<h2>Currently on SitePoint.com...</h2>
<dl>
<?php

$insideitem = false;
$tag = "";
$title = "";
$description = "";
$link = "";

function startElement($parser, $name, $attrs) {
	/*global $insideitem, $tag, $title, $description, $link;
	if ($insideitem) {
		$tag = $name;
	} elseif ($name == "ITEM") {
		$insideitem = true;
	}*/
	    global $errordata, $currentTag;

    $currentTag = $name;
}

function endElement($parser, $name) {
	/*global $insideitem, $tag, $title, $description, $link;
	if ($name == "ITEM") {
		printf("<dt><b><a href='%s'>%s</a></b></dt>",
			trim($link),htmlspecialchars(trim($title)));
		printf("<dd>%s</dd>",htmlspecialchars(trim($description)));
		$title = "";
		$description = "";
		$link = "";
		$insideitem = false;
	}*/
}

function characterData($parser, $data) {
	global $errordata, $currentTag, $i;
	if ($currentTag) {
	switch ($currentTag) {
		case "id":
		$title .= $data;
		break;
		case "text":
		$description .= $data;
		break;
	}
	}
}

$xml_parser = xml_parser_create();
xml_set_element_handler($xml_parser, "startElement", "endElement");
xml_set_character_data_handler($xml_parser, "characterData");
$fp = fopen("data/1.txt","r")
	or die("Error reading RSS data.");
while ($data = fread($fp, 4096))
	xml_parse($xml_parser, $data, feof($fp))
		or die(sprintf("XML error: %s at line %d", 
			xml_error_string(xml_get_error_code($xml_parser)), 
			xml_get_current_line_number($xml_parser)));
fclose($fp);
xml_parser_free($xml_parser);

?>
</dl>
</body>
</html>