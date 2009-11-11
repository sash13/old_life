<?php
/*возьмем в качестве примера - новости с сайта МТС. Пусть там формат RSS,
но без разницы: rss - это тот же XML */
$link = "data/1.txt";
$depth = array(); //глубина вложенных тегов

/* функции startElement, endElement и characterData определяются программером.
В них описано что делать с открывающим тегом, закрывающим и данными между ними соответсвенно. */
function startElement($parser, $name, $attrs)
{
 global $depth,$intag,$dist; /* $intag - внутри ли тега мы находимся. $dist (data exist) -
 есть ли между тегов данные. */
// $dist=0;
 //if($intag==1) echo "<br>"; //если в теге, то новая строка.
 for ($i = 0; $i < $depth[$parser]; $i++) // отступ для наглядности
  ///echo '<font color=ffffff>'.iconv("UTF-8","CP1251",$i).'</font>';
echo iconv("UTF-8","CP1251",$i);
 //echo "[$name]";
 //$depth[$parser]++;
 $intag=1; // - теперь уже точно в теге.
}

function endElement($parser, $name)
{
 global $depth,$intag,$dist;
 $depth[$parser]--;
 if ($dist==0) //если нет данных, то делаем отступ, соответсвующий глубине (для наглядности)
 {
  for ($i = 0; $i < $depth[$parser]; $i++)
   ///echo '<font color=ffffff>'.iconv("UTF-8","CP1251",$i).'</font>';
echo iconv("UTF-8","CP1251",$i);
 }
 $intag=0; //закрылся тег
 $dist=0; //и данные
 //echo "[/$name]<br>";
}

function characterData($parser, $data)
{
 global $dist,$intag;
 //echo '<font color=ff0000>'.iconv("UTF-8","CP1251",$data).'</font>';
echo iconv("UTF-8","CP1251",$data);
 if ($intag ==1) //если в теге, то есть данные.
  $dist=1;
}

//создаем парсер
$xml_parser = xml_parser_create(); 
//определяем функции открывающего и закрывающего тегов
xml_set_element_handler($xml_parser, "startElement", "endElement");
//и данных
xml_set_character_data_handler($xml_parser, "characterData");
//отключаем включенный по умолчанию верхний регистр
xml_parser_set_option($xml_parser, XML_OPTION_CASE_FOLDING, false);

if (!($fp = fopen($link, "r"))) die("could not open XML input");

//собственно парсинг
while ($data = fread($fp, 4096))
{
 if (!xml_parse($xml_parser, $data, feof($fp)))
  die(sprintf("XML error: %s at line %d", xml_error_string(xml_get_error_code($xml_parser)), xml_get_current_line_number($xml_parser)));
}
//не забываем очистить парсер
xml_parser_free($xml_parser);
?> 