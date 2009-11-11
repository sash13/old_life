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
<?php
$date = date ("d.m.y"); 
$time = date ("H:i:s");
$now = $date."/".$time;

$month = date ('n', time ());
$mon = date ('j', time ());
if ($month==1){$month_s='Январь';}
elseif ($month==2){$month_s='Февраль';}
elseif ($month==3){$month_s='Март';}
elseif ($month==4){$month_s='Апрель';}
elseif ($month==5){$month_s='Май';}
elseif ($month==6){$month_s='Июнь';}
elseif ($month==7){$month_s='Июль';}
elseif ($month==8){$month_s='Август';}
elseif ($month==9){$month_s='Сентябрь';}
elseif ($month==10){$month_s='Октябрь';}
elseif ($month==11){$month_s='Ноябрь';}
else {$month_s='Декабрь';}
$nis = $mon.' '.$month_s;
$ip=$_SERVER['REMOTE_ADDR'];

$id = prov($_GET["id"]);
function enter ()
{
$id = prov($_GET["id"]);
unset($_SESSION['captcha']);
$captcha = rand(1111111, 9999999);
$_SESSION['captcha'] = $captcha;
echo 'Вы <b>Гость</b><div class="navigation"></div><div id="CommentForm">
<fieldset>';
echo '<form action="kommnews.php?id='.$id.'#vvod" method="post">';
echo '<div><label for="userName">Ваше имя&nbsp;(Обязательное поле)</label>';
echo '<input type="text" name="nick" id="userNameHidden" maxlength="15" /></div>';
echo "Ваше сообщение:<br />\n";
echo '<div><label for="commentText">Текст&nbsp;(Обязательное поле)</label><textarea rows="10" cols="30" name="soob" id="commentText"></textarea>';
echo '<div><label for="authImage">Антиспам:</label></div>';
echo '<img src="capcha.php" alt="captcha"/><br />';
echo '<input type="text" id="authImage" maxlength="7"  name="captcha"/><br />';
//echo '<input type="submit" name="submit" value="Добавить"/><br /></form>';
echo '<input type="submit" name="submit" value="Добавить"/><br /></form></fieldset></div>';
}
/*<div class="navigation"></div><div id="CommentForm">
<fieldset>
<legend>Добавить комментарий</legend>
<div><label for="commentTopic">Заголовок</label><input name="commentTopic" id="commentTopic" value="" type="text"></div>
<div><label for="commentText">Текст&nbsp;(Обязательное поле)</label><textarea rows="10" cols="30" name="commentText" id="commentText"></textarea>

</div>
<div><label for="userName">Ваше имя&nbsp;(Обязательное поле)</label>
		<span id="AuthUser">sanih (Аутентификация)</span>

	<input name="userName" id="userNameHidden" value="sanih" type="hidden"></div>
	<div><label for="userEmail">Электронная почта</label><input name="userEmail" id="userEmail" value="" type="text"></div>
<div><label for="userUrl">Ваш сайт</label><input name="userUrl" id="userUrl" value="" type="text"></div>
<div><label for="authImage">Антиспам (вводите <strong>ТОЛЬКО ЦИФРЫ</strong>):</label>
<input name="authImage" id="authImage" value="" type="text">&nbsp;<img src="http://web20.primorye.name/index.php?op=AuthImageShow&amp;blogId=208" style="vertical-align: middle;" alt="authimage" width="70" height="20"></div>
<div id="Submit"><input id="Add" value="Отправить" name="Add" type="submit">
<input name="op" value="AddComment" type="hidden">
<input name="articleId" value="1221" type="hidden">
<input name="blogId" value="208" type="hidden">
<input name="parentId" value="" type="hidden"></div>

</fieldset></form></div>*/
function enter1 ()
{
$id = prov($_GET["id"]);
//echo '<br>Вы '.$login.'<br>';
echo '<div class="navigation"></div><div id="CommentForm">
<fieldset>
<legend>Добавить комментарий</legend>';
echo '<form action="kommnews.php?id='.$id.'#vvod" method="post">';
echo "Ваше сообщение:<br />\n";
echo '<div><label for="commentText">Текст&nbsp;(Обязательное поле)</label><textarea rows="10" cols="30" name="soob" id="commentText"></textarea>';
//echo '<input type="text" name="soob" maxlength="500" /><br/>';
echo '<div><label for="authImage">Антиспам:</label></div>';
unset($_SESSION['captcha']);

$captcha = rand(1111111, 9999999);
$_SESSION['captcha'] = $captcha;
echo '<img src="capcha.php" alt="captcha"/><br />';
echo '<input type="text" id="authImage" maxlength="7"  name="captcha"/><br />';
echo '<input type="submit" name="submit" value="Добавить"/><br /></form></fieldset></div>';
}
if(empty($_GET["page"])){
        $page = 0;
		
    } else {
if(!is_numeric($_GET["page"])) die("<br>Неправильный формат номера страницы!");
        $page = $_GET["page"];
    }
echo '<br>';

    if(empty($_GET["id"])){
        $id = 0;
		
    } else {
if(!is_numeric($_GET["id"])) die("<br>Неправильный номер баянчега");
        $id = $_GET["id"];
    }
echo '<br>';

$re = sprintf("SELECT*FROM news where id='%s'", 
mysql_real_escape_string($id));
$result = mysql_query($re);
if (mysql_num_rows($result) == 0)
{
echo "Произошла ошибка.Или ВЫ дэбил или хуезначто";
exit;
}

$re = sprintf("SELECT*FROM `news` where id='%s'",
mysql_real_escape_string($id));
$t=mysql_query($re);
while($data=mysql_fetch_array($t)){

echo '<div class="post-date">';
echo '<span class="post-month">'.$data[nis].'</span>';
echo '<!--span class="post-day">'.$data[nis].'</span-->';
echo '</div>';
echo '<div class="post-title">';
echo '<h2><a href="#" rel="bookmark">'.$data[zag].'</a></h2>';
echo '<span class="post-cat">';
echo '<a href="#">coming soon</a>';

echo '</span>';
echo '<span class="mini-add-comment"><a href="#">Добавить комментарий</a>&nbsp;&nbsp;&nbsp;</span>';

echo '</div>';
	//echo "<b>zag: </b> $data[zag]<br>";
	echo '<div class="post-content">';
	echo "$data[soder]<br>";
	echo "</div>";
	echo "<br><br>";
}

echo '<br>';


/////////////////////////////////////////////Вівод сообщений на страницу ВСЕ!!!/////////////////////////////
//$t = mysql_query("select * from `komsnews` where idkom='$id' ORDER BY now DESC") or die(mysql_error());;
//$t = mysql_query("select * from `komsnews` where idkom='$id'");
$re = sprintf("select * from `komsnews` where idkom='%s'",
mysql_real_escape_string($id));
$result = mysql_query($re);

//$re = sprintf("select * from `komsnews` where idkom='%s'",
//prov($id));
//$result = mysql_query($re);
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
///////////////////////////////////
if (isset($_POST['submit']))
{
echo "Коммент добавлен";
echo "<a href='kommnews.php?id=$id'>Нажмите сюда для обновления</a>";

}
//$t = mysql_query("select * from `koms` where idkom='$id' ORDER BY datetime DESC");
$t = mysql_query("select * from `komsnews` where idkom='$id' ORDER BY now DESC");
$count = mysql_num_rows($t);
if ($count==0)
{
echo '<h3 id="comments">Комментарии</h3>';
echo 'Коментов нету';
}
else
{
echo '<h3 id="comments">Комментарии</h3>';
echo '<ol class="commentlist">';
while ($data = mysql_fetch_array($t))
{
if ($i >= $start && $i < $end)
{

echo '<li class="alt" id="comment-'.$id.'">';

echo'<div class="comm-top">';
echo'<cite>'.$data[login].'</cite>';
echo'<br>';
echo'<small class="commentmetadata"><a href="#comment-'.$id.'" title="">'.$data[now].'</a></small>';
echo'</div>';
echo'<div class="comm-bg">';
echo'<p>'.$data[soob].'</p>';

echo'</div>';
echo'<div class="comm-bot">';
echo'</div>';
echo'</li>';

//echo "Добавил: $data[login]<br>";
//echo "Сообщение:<br>$data[soob]<br>";
//echo "$data[nis]";
//echo "<br>$data[idkom]";
//echo "<hr>";
}
   ++$i;

}
echo'</ol>';
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
        echo '<a href="kommnews.php?page=' . ($page - 1) . '">&lt;&lt;</a> ';
    }
    if ($offpg != 1)
    {
        if ($asd < $count && $asd > 0)
        {
            echo ' <a href="kommnews.php?page=1&amp;">1</a> .. ';
        }
        $page2 = $ba - $page;
        $pa = ceil($page / 2);
        $paa = ceil($page / 3);
        $pa2 = $page + floor($page2 / 2);
        $paa2 = $page + floor($page2 / 3);
        $paa3 = $page + (floor($page2 / 3) * 2);
        if ($page > 13)
        {
            echo ' <a href="kommnews.php?page=' . $paa . '&id=' . $id . '">' . $paa . '</a> <a href="kommnews.php?page=' . ($paa + 1) . '&id=' . $id . '">' . ($paa + 1) . '</a> .. <a href="kommnews.php?page=' . ($paa * 2) . '&id=' . $id . '">' . ($paa * 2) . '</a> <a href="kommnews.php?page=' . ($paa * 2 +
                1) . '&id=' . $id . '">' . ($paa * 2 + 1) . '</a> .. ';
        } elseif ($page > 7)
        {
            echo ' <a href="kommnews.php?page=' . $pa . '&id=' . $id . '">' . $pa . '</a> <a href="kommnews.php?page=' . ($pa + 1) . '&id=' . $id . '">' . ($pa + 1) . '</a> .. ';
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
                    echo ' <a href="kommnews.php?page=' . $ii . '&id=' . $id . '">' . $ii . '</a> ';
                }
            }
            $i = $i + 10;
        }
        if ($page2 > 12)
        {
            echo ' .. <a href="kommnews.php?page=' . $paa2 . '&id=' . $id . '">' . $paa2 . '</a> <a href="kommnews.php?page=' . ($paa2 + 1) . '&id=' . $id . '">' . ($paa2 + 1) . '</a> .. <a href="kommnews.php?page=' . ($paa3) . '&id=' . $id . '">' . ($paa3) . '</a> <a href="kommnews.php?page=' . ($paa3 + 1) .
                '&id=' . $id . '">' . ($paa3 + 1) . '</a> ';
        } elseif ($page2 > 6)
        {
            echo ' .. <a href="kommnews.php?page=' . $pa2 . '&id=' . $id . '">' . $pa2 . '</a> <a href="kommnews.php?page=' . ($pa2 + 1) . '&id=' . $id . '">' . ($pa2 + 1) . '</a> ';
        }
        if ($asd2 < $count)
        {
            echo ' .. <a href="kommnews.php?page=' . $ba . '&id=' . $id . '">' . $ba . '</a>';
        }
    } else
    {
        echo "<b>[$page]</b>";
    }


    if ($count > $start + 10)
    {
        echo ' <a href="kommnews.php?page=' . ($page + 1) . '&id=' . $id . '">&gt;&gt;</a>';
    }
}
if (isset($_POST['submit']))
{
if(!$user)
{
$captcha = prov(intval($_POST['captcha']));
$nick = prov(trim($_POST['nick']));
$soob = prov(trim($_POST['soob']));
}
else
{
$captcha = prov(intval($_POST['captcha']));
$soob = prov(trim($_POST['soob']));
}
$error = false;
if(!$user)
{
   if (empty($nick))
   {
     $error = $error . '<br>Не введён ник!<br/>';
   }
   if (empty($soob))
   {
     $error = $error . '<br>Не введёно сообщение!<br/>';
   }
   if (empty($captcha))
   {
     $error = $error . '<br>Не введёна капчя!<br/>';
   }
   elseif ($captcha != $_SESSION['captcha'])
   {
   $error = $error . '<br>Введённый Вами код и код с картинки несовпадают!<br/>';
   unset($_SESSION['captcha']);
   }
}
else
{
   if (empty($soob))
   {
     $error = $error . '<br>Не введёно сообщение!<br/>';
   }
    if (empty($captcha))
   {
     $error = $error . '<br>Не введёна капчя!<br/>';
   }
   elseif ($captcha != $_SESSION['captcha'])
   {
   $error = $error . '<br>Введённый Вами код и код с картинки несовпадают!<br/>';
   unset($_SESSION['captcha']);
   }
}
   if (empty($error))
   {
   unset($_SESSION['captcha']);
   echo '<br>Коментарий добавлен!!';
$id = prov($_GET["id"]);
if(!$user)
{
$login = 'Гость<b> '.$nick.'</b>';
}
else
{
$login= $user['login'];
}
$query = "insert into komsnews values(null,'$id','$login','$soob','$now','$ip','$nis')"; 
mysql_query($query);
echo "<a href='kommnews.php?id=$id'>Нажмите сюда для обновления</a>";

   }
   else
   {
if(!$user)
{
echo '<li class="alt" id="vvod"><a href="#vvod" title=""></a>';
echo $error;
echo 'Ты не авторизирован..Так что сообщение будет от гостя..';
enter ();
echo '</li>';
}
else
{
echo '<li class="alt" id="vvod"><a href="#vvod" title=""></a>';
echo $error;
enter1 ();
echo '</li>';

}
}
}
else
{
if(!$user)
{
echo 'Вы не авторизирован..Так что сообщение будет от гостя..';
enter ();
}
else
{
enter1 ();

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