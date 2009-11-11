<?
//for($i=1;$i<=60;$i++)
//{
$str = 'http://www.xkcd.ru/img/';
$per = file_get_contents($str); 
echo $str.'<br>';
$fp = fopen('bash/xkdc.txt', 'w');
fwrite($fp, $per);
fclose($fp);
//}
?>