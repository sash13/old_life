<?


	error_reporting(E_ALL);

	$mysql_host 		= "localhost";
	$mysql_user 		= "text";
	$mysql_password 	= "iHkOeZxi";
	$mysql_db 		= "bash";
	
	$mysql_link = @mysql_connect($mysql_host, $mysql_user, $mysql_password) or die("Cant connect to mysql server.");
	@mysql_select_db($mysql_db) or die("Cant select db");
	
	$content = file_get_contents("http://bash.org.ru"); // Берем страницу
	
	preg_match_all('/<div class="q">([\s\S]+?)<\/div>\t\t\t/', $content, $out); // Выбираем все записи
	$quotes = $out[1];
	
	foreach ($quotes as $quote) {
		
		
		preg_match('/<div>([\s\S]+?)<\/div>/', $quote, $out); // Берем текст записи
		$bash_text = $out[1];
		
		$bash_text = iconv("windows-1251", "utf-8", $bash_text); // текст в UTF8
		
		preg_match('/\/quote\/([0-9]+)/', $quote, $out); // ID записи в баше
		$bash_id = $out[1];
			
		$r = mysql_query("SELECT bash_id FROM bash_quotes WHERE `bash_id`={$bash_id}"); // Проверяем есть ли у нас уже такая запись
		if (mysql_num_rows($r)==0) {
			mysql_query("INSERT INTO bash_quotes
						(`bash_id`,	`text`)
							VALUES
						('{$bash_id}', '{$bash_text}')");
		}
		
	}