<html>
<head>

</head>
<body>
<?php

function date2unixstamp($s) {
 $months = array ( "Jan"=>1, "Feb"=>2, "Mar"=>3, "Apr"=>4, "May"=>5, "Jun"=>6, "Jul"=>7, "Aug"=>8, "Sep"=>9, "Oct"=>10, "Nov"=>11, "Dec"=>12);
  $a = explode(" ", $s); 
  $b = explode(":", $a[4]); 
  return $months[$s];
   } 
   
$dblocation = "localhost";
$dbname = "repo";
$dbuser = "repo";
$dbpasswd = "vCNFtclO";
$dbcnx = @mysql_connect($dblocation,$dbuser,$dbpasswd);
if (!$dbcnx) exit("<p>К сожалению, не доступен сервер MySQL</p>");
if (!@mysql_select_db($dbname,$dbcnx)) exit("<p>К сожалению, не доступна база данных</p>");
global $contents,$bigbig,$contentsi;
//$contentsi = '404991';
		$filename = "data/test1.txt";
        $handle = fopen($filename, "r");
        $contents = fread($handle, filesize($filename));
      //  echo $contents.'  for test';
        fclose($handle);
        $contentsi = $contents;
$insideitem = false;
$tag = "";
$title = "";
$description = "";
$link = "";

function startElement($parser, $name, $attrs) {
	global $insideitem, $tag, $title, $description, $link;
	if ($insideitem) {
		$tag = $name;
	} elseif ($name == "ITEM") {
		
		$insideitem = true;
	}
}

function endElement($parser, $name) {
	global $insideitem, $tag, $title, $description, $link,$contents,$bigbig,$contentsi;
	if ($name == "ITEM") {
        $test1 = iconv("UTF-8","CP1251",$title);
        list($testss, $outssss) = split('[#.-]', $test1);
        
		if(preg_match("/$contentsi/i", $outssss))
		{
		//$content = '?????? #404963';
        //list($test, $out) = split('[#.-]', $content);
        echo $contentsi.'konec <br>'.$outssss;
       // $fpss = fopen("data/test.txt","w+");
        //fwrite($fpss, $bigbig);
        //fclose($fpss);
			exit();
		}
		else
		{
		
		$one =iconv("UTF-8","CP1251",$title);
		$two =iconv("UTF-8","CP1251",$description);
		$tree =iconv("UTF-8","CP1251",$link);
		 $tree = str_replace("<br>","\n",$tree);
		 $tree = htmlspecialchars_decode($tree, ENT_QUOTES);
		list($testsss, $my) = split('[#.-]', $one);
		///echo $outsss.'   '.$testsss;
		if($contents < $my)
		{
			$contents = $my;
			$bigbig = $my;
			//$fpss = fopen("data/test.txt","w+");
            //fwrite($fpss, $bigbig);
            //fclose($fpss);
			echo $bigbig.' vozmowhno';
			
			$fpss = fopen("data/test1.txt","w+");
fwrite($fpss, $bigbig);
fclose($fpss);

echo $contents.'contentss <br>';
echo $bigbig;
		}
		
		list($day, $dayc, $mou, $god, $time) = split('[ .-]', $two);
$last_date = date2unixstamp($mou); 
list($chas,$times) = split('[:.-]', $time);
         $datethisis = $dayc.'/'.$last_date.'/'.$god.' '.$chas.':'.$times;
         //echo "$dayc/$last_date/$god, $chas:$times<br />\n";
		echo $one.'<br>'.$datethisis.'<br>'.$tree.'<br><br>';
		$query = "insert into bashorgru values(null, '$my','$datethisis','$tree')"; 
		mysql_query($query);
		}
		//$query = "insert into bashorgru values(null, '$one','$two','$tree')"; 
        //mysql_query($query);
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
		case "TITLE":
		$title .= $data;
		break;
		case "PUBDATE":
		$description .= $data;
		break;
		case "DESCRIPTION":
		$link .= $data;
		break;
	}
	}
}
$xml_parser = xml_parser_create();
xml_set_element_handler($xml_parser, "startElement", "endElement");
xml_set_character_data_handler($xml_parser, "characterData");
$fp = fopen("http://bash.org.ru/rss/","r")
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