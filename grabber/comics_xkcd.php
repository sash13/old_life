<?
header("Content-type: text/html; charset=utf-8");

    $filename = 'bash/xkdc.txt';
	$handle = fopen($filename, "r");
    $content = fread($handle, filesize($filename));
  
//$content = file_get_contents("http://bash.org.ru"); // Берем страницу
	preg_match_all('/<a href="\/([\s\S]+?)"><\/a>/', $content, $out); // Выбираем все записи
	$quotes = $out[1];
	print_r($quotes);
	/*foreach ($quotes as $quote) {
		
		
		preg_match('/<div>([\s\S]+?)<\/div>/', $quote, $out); // Берем текст записи
		$bash_text = $out[1];
		
		$bash_text = iconv("windows-1251", "utf-8", $bash_text); // текст в UTF8
	//	/src="\/([\s\S]+?)" \/><\/a>/
        preg_match('/" src="\/([\s\S]+?)" \/><\/a>/', $quote, $out);
		//preg_match('/\/quote\/([0-9]+)/', $quote, $out); // ID записи в баше
		$bash_id = $out[1];

        if((preg_match("/iframe/i", $bash_text)) || (preg_match("/script/i", $bash_text))){}
		else{ echo $bash_text.'<br><img src="http://comicsia.ru/'.$bash_id.'" /></a><br>';
		}
		//$r = mysql_query("SELECT bash_id FROM bash_quotes WHERE `bash_id`={$bash_id}"); // Проверяем есть ли у нас уже такая запись
		//if (mysql_num_rows($r)==0) {
		//	mysql_query("INSERT INTO bash_quotes
		//				(`bash_id`,	`text`)
		//					VALUES
		//				('{$bash_id}', '{$bash_text}')");
		//}
		*/
	//}
	fclose($handle);
	