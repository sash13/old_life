<?
$dblocation = "localhost";
$dbname = "repo";
$dbuser = "repo";
$dbpasswd = "vCNFtclO";
$dbcnx = @mysql_connect($dblocation,$dbuser,$dbpasswd);
if (!$dbcnx) exit("436346");
if (!@mysql_select_db($dbname,$dbcnx)) exit("235235");
$re = sprintf("SELECT*FROM `bashorgrutest` ORDER BY idquote DESC LIMIT 100");
$t=mysql_query($re);
while($data=mysql_fetch_array($t)){
//echo '<quote>';
echo '<b>'.$data[idquote].'</b><br>';
//echo '<text><![CDATA['.$data[text].']]></text>';
echo $data[text].'<br>';
//echo '</quote>';

}
//echo '</result>';
?>