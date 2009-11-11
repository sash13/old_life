<?
function date2unixstamp($s) {
 $months = array ( "Jan"=>1, "Feb"=>2, "Mar"=>3, "Apr"=>4, "May"=>5, "Jun"=>6, "Jul"=>7, "Aug"=>8, "Sep"=>9, "Oct"=>10, "Nov"=>11, "Dec"=>12);
  $a = explode(" ", $s); 
  $b = explode(":", $a[4]); 
  return $months[$s];
   } 

$dblocation = "Mon, 09 Feb 2009 09:12:26 +0400";
list($day, $dayc, $mou, $god, $time) = split('[ .-]', $dblocation);
$last_date = date2unixstamp($mou); 
list($chas,$times) = split('[:.-]', $time);
echo "$dayc/$last_date/$god, $chas:$times<br />\n";
?>