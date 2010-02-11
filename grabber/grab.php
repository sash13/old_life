<?
//for($i=1;$i<=60;$i++)
//{
$str = 'http://xkcd.saran.in.th/retrieve.php?last_id=0';
$per = file_get_contents($str); 
echo $str.'<br>';
$fp = fopen('xkdcfull.txt', 'w');
fwrite($fp, $per);
fclose($fp);
//}
?>