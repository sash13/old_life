<?
include_once "head.php";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru" lang="ru" dir="ltr">
<title>Репозиторий iphone</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf8" />
<link rel="stylesheet" type="text/css" media="all" href="style.css" />
<link rel="stylesheet" media="all" type="text/css" href="menus.css" />

</head>

<body>

<div class="sitejr">
<div class="topjr1"><div class="toptextjr"><h1><a href="http://repo/" title="web20">Репозиторий</a></h1></div></div>
<div class="topjr2">
<div class="top-menu">
<?
include_once "topmenu.php";
?>
</div>
<div class="topsearch">
<form method="post" id="searchform" action="#">
<div>
<input type="text" name="searchTerms" value="" id="s" />
<input type="hidden" name="op" value="Search" />
<input type="hidden" name="blogId" value="208"/>
<input type="submit" name="Search" value="Поиск" />
</div>
</form>
</div>
</div>

<div class="topjr"></div>

<div class="mainbg">
<div class="contentjr">		<div class="post">


<?
include_once "head.php";
if(empty($_GET["page"])){
$page = 0;

} else {
if(!is_numeric($_GET["page"])) 
die('Эххх');

   $page = $_GET["page"];
 }
if($page<0)
{
echo 'yyy';
exit;}

echo '<br>';
	
//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////Вівод сообщений на страницу ВСЕ!!!/////////////////////////////
$result = mysql_query("select * from `news`;");
	$count = mysql_num_rows($result);
if (empty($_GET['page']))
{
    $page = 1;
} else
{
    $page = intval($_GET['page']);
}
$start = $page * 10 - 10;
if ($count < $start + 10)
{
    $end = $count;
} else
{
    $end = $start + 10;
}
if($count<intval($_GET["page"])) 
die('Эххх');

///////////////////////////////////


$t = mysql_query("select * from `news` ORDER BY now DESC");
while ($data = mysql_fetch_array($t))
{
  if ($i >= $start && $i < $end)
   {
   $count = mysql_num_rows($result);
echo '<div class="post-date">';
echo '<span class="post-month">'.$data[nis].'</span>';
echo '<!--span class="post-day">'.$data[nis].'</span-->';
echo '</div>';
echo '<div class="post-title">';
echo '<h2><a href="#" rel="bookmark">'.$data[zag].'</a></h2>';
echo '<span class="post-cat">';
echo '<a href="#">coming soon</a>';
$resu = mysql_query("select * from `komsnews` where idkom='$data[id]' ORDER BY now DESC");
$coun = mysql_num_rows($resu);
echo '</span>';
echo '<span class="mini-add-comment"><a href="kommnews.php?id='.$data[id].'#">Добавить комментарий ('.$coun.')</a>&nbsp;&nbsp;&nbsp;</span>';

echo '</div>';
	//echo "<b>zag: </b> $data[zag]<br>";
	echo '<div class="post-content">';
	echo "$data[soder]<br>";
	echo "</div>";
	echo "<br><br>";
//	echo "<hr>";
	//echo "</div>";
	//echo ' <a href="../avik.php?avt='.$fr1[avik].'">Изменить</a><br />';

   }
   ++$i;

}
////////////////////////////////////////
if ($count > 10)
{
    $ba = ceil($count / 10);
    if ($offpg != 1)
    {
        echo "Страницы:<br/>";
    } else
    {
        echo ": $ba<br/>";
    }
    $asd = $start - (10);
    $asd2 = $start + (10 * 2);

    if ($start != 0)
    {
        echo '<a href="index.php?page=' . ($page - 1) . '">&lt;&lt;</a> ';
    }
    if ($offpg != 1)
    {
        if ($asd < $count && $asd > 0)
        {
            echo ' <a href="index.php?page=1&amp;">1</a> .. ';
        }
        $page2 = $ba - $page;
        $pa = ceil($page / 2);
        $paa = ceil($page / 3);
        $pa2 = $page + floor($page2 / 2);
        $paa2 = $page + floor($page2 / 3);
        $paa3 = $page + (floor($page2 / 3) * 2);
        if ($page > 13)
        {
            echo ' <a href="index.php?page=' . $paa . '">' . $paa . '</a> <a href="index.php?page=' . ($paa + 1) . '">' . ($paa + 1) . '</a> .. <a href="index.php?page=' . ($paa * 2) . '">' . ($paa * 2) . '</a> <a href="index.php?page=' . ($paa * 2 +
                1) . '">' . ($paa * 2 + 1) . '</a> .. ';
        } elseif ($page > 7)
        {
            echo ' <a href="index.php?page=' . $pa . '">' . $pa . '</a> <a href="index.php?page=' . ($pa + 1) . '">' . ($pa + 1) . '</a> .. ';
        }
        for ($i = $asd; $i < $asd2; )
        {
            if ($i < $count && $i >= 0)
            {
                $ii = floor(1 + $i / 10);

                if ($start == $i)
                {
                    echo " <b>$ii</b>";
                } else
                {
                    echo ' <a href="index.php?page=' . $ii . '">' . $ii . '</a> ';
                }
            }
            $i = $i + 10;
        }
        if ($page2 > 12)
        {
            echo ' .. <a href="index.php?page=' . $paa2 . '">' . $paa2 . '</a> <a href="index.php?page=' . ($paa2 + 1) . '">' . ($paa2 + 1) . '</a> .. <a href="index.php?page=' . ($paa3) . '">' . ($paa3) . '</a> <a href="index.php?page=' . ($paa3 + 1) .
                '">' . ($paa3 + 1) . '</a> ';
        } elseif ($page2 > 6)
        {
            echo ' .. <a href="index.php?page=' . $pa2 . '">' . $pa2 . '</a> <a href="index.php?page=' . ($pa2 + 1) . '">' . ($pa2 + 1) . '</a> ';
        }
        if ($asd2 < $count)
        {
            echo ' .. <a href="index.php?page=' . $ba . '">' . $ba . '</a>';
        }
    } else
    {
        echo "<b>[$page]</b>";
    }


    if ($count > $start + 10)
    {
        echo ' <a href="index.php?page=' . ($page + 1) . '">&gt;&gt;</a>';
    }
}
?>
</div>	<div class="navigation"></div>
</div>
<?
include_once "toolbar.php";
?>
<div class="footerjr"></div>
</div>
</div>
<div class="footerjr2">

<div class="footer1">
<div class="styleBottom"><a href="#" target="_blank" class="styleBottom">Нофка</a></div>
</div>
<div class="footer2">
<div class="styleBottom"><a href="#" target="_blank" class="styleBottom">Нофка</a></div>
</div>
</div>

</body>
</html>