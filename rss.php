<?php 



function build_rss($path="/data/complete", $recursive =true){

	if ($handle=opendir($path)){
		while ($file = readdir($handle)){
			if($file !='.' && $file !='..'){
				$fullPath = $path."/".$file;
				if(is_dir($fullPath) && $recursive){
					build_rss($fullPath);
				}else if(is_file($fullPath)){
					echo "  <item>
    <title>".$file."</title>
    <link>".str_replace('/data/','sftp://root:XLsior942@'.$_SERVER['HTTP_HOST'].'/home/netbox/mounted/',$fullPath)."</link>
    <description>movie</description>
  </item>";
				}
			}

		}


		closedir($handle);
	}

}

?>


<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0">

<channel>
  <title>Vids</title>
  <link>http://www.thecodertips.com</link>
  <description>Web developement tutorials</description>
  <?php build_rss(); ?>
 
</channel>

</rss>