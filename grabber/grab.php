<?
for($i=1;$i<=60;$i++)
{
$str = 'http://comicsia.ru/collections/bor/'.$i.'';
$per = file_get_contents($str); 
echo $str.'<br>';
$fp = fopen('bash/'.$i.'.txt', 'w');
fwrite($fp, $per);
fclose($fp);
}
?>