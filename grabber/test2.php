
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>

<head>

<?php
$insideitem = false;
$currentTag = "";
$title = "";
$id = "";
$data = "";

function startElement($parser, $name, $attr){

    global $errordata, $currentTag,$insideitem,$title,$id,$data;

   // $currentTag = $name;
    
    	if ($insideitem) {
		$currentTag = $name;
	} elseif ($name == "ITEM") {
		$insideitem = true;
	}

}

    

function endElement ($parser, $name){
	GLOBAL $insideitem,$title,$id,$data;
	if ($name == "QUOTE") {
		printf("<dt><b><a href='%s'>%s</a></b></dt>",
		trim($data),htmlspecialchars(trim($id)));
		printf("<dd>%s</dd>",htmlspecialchars(trim($title)));
		$title = "";
		$id = "";
		$data = "";
		$insideitem = false;
	}

}



function characterData ($parser, $data){

    global $errordata, $currentTag, $i, $insideitem,$title,$id,$data;

   /* if($currentTag){
    switch ($currentTag){

        case "id":
            if (empty($data)) {}
            else {$one = iconv("UTF-8","CP1251",$data);}

            break;

        case "text":
            if (empty($data)) {}
            else {$two = iconv("UTF-8","CP1251",$data);}

            break;

    }
    }
    echo $one.'::'.$two.'<br>'; */

	if ($insideitem) {
	switch ($currentTag) {
		case "TITLE":
		$title .= $data;
		break;
		case "ID":
		$id .= $data;
		break;
		case "DATE":
		$data .= $data;
		break;
	}
	}
}



// ???????????°?»???·?°?????? ???µ???µ???µ????????

$file = "1.txt";

$currentTag = "";

$errordata = 0;

$i = 1;

  $xml_parser = xml_parser_create();
xml_set_element_handler($xml_parser, "startElement", "endElement");
xml_set_character_data_handler($xml_parser, "characterData");
$fp = fopen("1.txt","r")
	or die("Error reading RSS data.");
while ($data = fread($fp, 4096))
	xml_parse($xml_parser, $data, feof($fp))
		or die(sprintf("XML error: %s at line %d", 
			xml_error_string(xml_get_error_code($xml_parser)), 
			xml_get_current_line_number($xml_parser)));
fclose($fp);
xml_parser_free($xml_parser);
  

/*$xml_parser = xml_parser_create();

    xml_set_element_handler($xml_parser, "startElement", "endElement");

    xml_set_character_data_handler($xml_parser, "characterData");

    xml_parser_set_option($xml_parser, XML_OPTION_CASE_FOLDING, false);

    

If (!($fp = @fopen($file, "r"))) {

    echo "Could not open $file for reading&lt;br&gt;";

    continue;

}



while ($data = fread($fp, 4096)){

    if(!xml_parse($xml_parser, $data, feof($fp))){

        die(sprintf("XML error at line %d column %d",

        xml_get_current_line_number($xml_parser),

        xml_get_current_column_number($xml_parser)));

    }

}

    

xml_parser_free($xml_parser);

@fclose($fp);
*/
?>

</body>

</html>