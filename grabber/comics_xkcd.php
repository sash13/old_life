<?
header("Content-type: text/html; charset=utf-8");
$dblocation = "localhost";
$dbname = "repo";
$dbuser = "repo";
$dbpasswd = "vCNFtclO";
$dbcnx = @mysql_connect($dblocation,$dbuser,$dbpasswd);
if (!$dbcnx) exit("<p>√Р¬Ъ √С¬Б√Р¬Њ√Р¬ґ√Р¬∞√Р¬ї√Р¬µ√Р¬љ√Р¬Є√С¬О, √Р¬љ√Р¬µ √Р¬і√Р¬Њ√С¬Б√С¬В√С¬Г√Р¬њ√Р¬µ√Р¬љ √С¬Б√Р¬µ√С¬А√Р¬≤√Р¬µ√С¬А MySQL</p>");
if (!@mysql_select_db($dbname,$dbcnx)) exit("<p>√Р¬Ъ √С¬Б√Р¬Њ√Р¬ґ√Р¬∞√Р¬ї√Р¬µ√Р¬љ√Р¬Є√С¬О, √Р¬љ√Р¬µ √Р¬і√Р¬Њ√С¬Б√С¬В√С¬Г√Р¬њ√Р¬љ√Р¬∞ √Р¬±√Р¬∞√Р¬Ј√Р¬∞ √Р¬і√Р¬∞√Р¬љ√Р¬љ√С¬Л√С¬Е</p>");
    $filename = 'bash/xkdc.txt';
    //$filename = 'http://www.xkcd.ru/img/';
	$handle = fopen($filename, "r");
    $content = fread($handle, filesize($filename));
//$content = file_get_contents($filename);
  
//$content = file_get_contents("http://bash.org.ru"); // –С–µ—А–µ–Љ —Б—В—А–∞–љ–Є—Ж—Г
       $content=preg_replace('|<ul class="lnk">([\s\S]+?)</ul>|','', $content); 
//$content=str_replace('<li><a href="/">last</a>','', $content); 
	preg_match_all('/<a href="\/([\s\S]+?)"><\/a>/', $content, $out); // –Т—Л–±–Є—А–∞–µ–Љ –≤—Б–µ –Ј–∞–њ–Є—Б–Є
	$quotes = $out[1];
	//print_r($quotes);
	foreach ($quotes as $quote) {
		
		
		preg_match('/([\s\S]+?)\/"><img class/', $quote, $out); // –С–µ—А–µ–Љ —В–µ–Ї—Б—В –Ј–∞–њ–Є—Б–Є
		$id = $out[1];
		
		//$bash_text = iconv("windows-1251", "utf-8", $bash_text); // —В–µ–Ї—Б—В –≤ UTF8
	//	/src="\/([\s\S]+?)" \/><\/a>/
        preg_match('/border=0 src="([\s\S]+?)" width/', $quote, $out);
		//preg_match('/\/quote\/([0-9]+)/', $quote, $out); // ID –Ј–∞–њ–Є—Б–Є –≤ –±–∞—И–µ
		$img = $out[1];
		
		preg_match('/title="([\s\S]+?)" alt/', $quote, $out);
		$info = $out[1];
		//$info = iconv("windows-1251", "utf-8", $info);
        $thisisit = 'http://www.xkcd.ru/'.$id.'/';
        $contentt = file_get_contents($thisisit);
        preg_match('/<img border=0 src="http:\/\/www.xkcd.ru([\s\S]+?)" alt="/', $contentt, $out);
        $fulllink = $out[1];
        preg_match('/<div class="comics_text">([\s\S]+?)<\/div>/', $contentt, $out);
        $fulltext = $out[1];
        //$fulltext = iconv("windows-1251", "utf-8", $fulltext);
        //if((preg_match("/iframe/i", $bash_text)) || (preg_match("/script/i", $bash_text))){}
		//else{ 
			if($id==0) {exit;}
			
			else{ 
				echo $id.'<br>'.$img.'  '.$info.'  http://www.xkcd.ru'.$fulllink.'<br>'.$fulltext.'<br><br>';
				$fullimg = 'http://www.xkcd.ru'.$fulllink.'';
					$query = "insert into xkcd values(null, '$id','$img','$info','$fullimg','$fulltext')"; 
		            mysql_query($query);
				}
		//}
		//$r = mysql_query("SELECT bash_id FROM bash_quotes WHERE `bash_id`={$bash_id}"); // –Я—А–Њ–≤–µ—А—П–µ–Љ –µ—Б—В—М –ї–Є —Г –љ–∞—Б —Г–ґ–µ —В–∞–Ї–∞—П –Ј–∞–њ–Є—Б—М
		//if (mysql_num_rows($r)==0) {
		//	mysql_query("INSERT INTO bash_quotes
		//				(`bash_id`,	`text`)
		//					VALUES
		//				('{$bash_id}', '{$bash_text}')");
		//}
		
	}
	fclose($handle);
	