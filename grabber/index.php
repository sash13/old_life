<?
$filename = "data/1.txt";
$handle = fopen($filename, "r");
$rss= fread($handle, filesize($filename));

if ($rss) {    
        preg_match_all("/id>[^>]+>/", $rss, $title);         //������ �����
        //preg_match_all("/text>[^<]+</text>/", $rss, $description);              //������ �����������
       
        $count = count($title[0])-1;    //����� �������� �����.
       
        for ($i=0; $i < $count; $i++) {
                echo '<h1>'.substr($title[0][$i+1], 6, -8).'</h1>';             //������� �� ������ ��������� ������
                echo substr($description[0][$i], 13, -14);              //������� �� ������ ����� ������
        }
} else {
        echo '<font color="red">������ �������� '.$url.'</font>';      
//������� ������ ���� file_get_contents() ������� false
}
?>