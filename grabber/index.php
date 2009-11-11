<?
$filename = "data/1.txt";
$handle = fopen($filename, "r");
$rss= fread($handle, filesize($filename));

if ($rss) {    
        preg_match_all("/id>[^>]+>/", $rss, $title);         //парсим титлы
        //preg_match_all("/text>[^<]+</text>/", $rss, $description);              //парсим дескрипшены
       
        $count = count($title[0])-1;    //число проходов цикла.
       
        for ($i=0; $i < $count; $i++) {
                echo '<h1>'.substr($title[0][$i+1], 6, -8).'</h1>';             //выводим на печать заголовок статьи
                echo substr($description[0][$i], 13, -14);              //выводим на печать текст статьи
        }
} else {
        echo '<font color="red">Ошибка парсинга '.$url.'</font>';      
//выводим ошибку если file_get_contents() вернула false
}
?>