<html>
<head>

</head>
<body>
<?php
$dblocation = "localhost";
$dbname = "repo";
$dbuser = "repo";
$dbpasswd = "vCNFtclO";
$dbcnx = @mysql_connect($dblocation,$dbuser,$dbpasswd);
if (!$dbcnx) exit("<p>К сожалению, не доступен сервер MySQL</p>");
if (!@mysql_select_db($dbname,$dbcnx)) exit("<p>К сожалению, не доступна база данных</p>");

$insideitem = false;
$tag = "";
$title = "";
$description = "";
$link = "";

function startElement($parser, $name, $attrs) {
	global $insideitem, $tag, $title, $description, $link;
	if ($insideitem) {
		$tag = $name;
	} elseif ($name == "QUOTE") {
		$insideitem = true;
	}
}

function endElement($parser, $name) {
	global $insideitem, $tag, $title, $description, $link;
	if ($name == "QUOTE") {
		$one =iconv("UTF-8","CP1251",$title);
		$two =iconv("UTF-8","CP1251",$description);
		$tree =iconv("UTF-8","CP1251",$link);
		//echo $one.'<br>'.$two.'<br>'.$tree.'<br><br>';
		
		$query = "insert into bashorgru values(null, '$one','$two','$tree')"; 
        mysql_query($query);
		//printf("<dt><b><a href='%s'>%s</a></b></dt>",
		//	trim($link),htmlspecialchars(trim($title)));
		//printf("<dd>%s</dd>",htmlspecialchars(trim($description)));
		$one ='';
		$two ='';
		$tree ='';
		$title = "";
		$description = "";
		$link = "";
		$insideitem = false;
	}
}

function characterData($parser, $data) {
	global $insideitem, $tag, $title, $description, $link;
	if ($insideitem) {
	switch ($tag) {
		case "ID":
		$title .= $data;
		break;
		case "DATE":
		$description .= $data;
		break;
		case "TEXT":
		$link .= $data;
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
</body>
</html>