<?php

echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 3.2 Final//EN\">";

$cwd = realpath( "." );
//echo $cwd . "<br>";

$user = basename( $cwd );
//echo $user . "<br>";

$title = "Index of igprof profiles for $user";
echo "<html><head><title>$title</title></head>\n";
echo "<body><h1>$title</h1>\n";

echo "<hr><pre>\n";

$nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
echo "<table cellpadding=2>\n";
echo "<tr><td></td><td>Name</td><td>$nbsp</td><td>Size</td><td>$nbsp</td><td>Last modified</td></tr>\n";
echo "<tr><td><img src=\"/icons/back.gif\"$nbsp></td><td><a href=\"\">Back to directory</a></td></tr>\n";
$dir = "data";
foreach ( glob( $dir . "/*.sql3" ) as $fname ) 
{
  $fbnam = basename( $fname, ".sql3" );  
  $fsize = filesize( $fname );
  $fctim = date( "d-M-Y H:i", filectime($fname) );
  $flink = "https://test-coral-igprof.web.cern.ch/test-coral-igprof/cgi-bin/igprof-navigator/" . $user . "/" . $fbnam;
  echo "<tr><td><img src=\"/icons/text.gif\"></td><td><a href=\"$flink\">$fbnam</a></td><td></td><td>$fsize</td><td></td><td>$fctim</td></tr>\n";
}
echo "</table>\n";

echo "<hr></pre></body></html>\n";

?>
