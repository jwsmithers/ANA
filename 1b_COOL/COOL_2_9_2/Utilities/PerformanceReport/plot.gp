# Old font settings for gnuplot42 on SLC5
# On SLC5/gnuplot42 this ends up using a non-scalable internal font,
# after printing an error that it cannot find the arial font.
# On SLC6/gnuplot44 this ends up using arial which is found.
# But I prefer the non-scalable internal font!
###set terminal png

# New font settings for gnuplot42 on SLC5 and gnuplot44 on SLC6
# This is the non-scalable internal font that I was already using
# on SLC5 and that I will now use also on SLC6.
# See http://www.gnuplot.info/docs_4.4/gnuplot.pdf (section 14.2)
set terminal png medium

set xlabel "`echo $GNUPLOT_XLABEL`"
set ylabel "`echo $GNUPLOT_YLABEL`"
set format x "%gk"
set title "`echo $GNUPLOT_TITLE`"
set key `echo $GNUPLOT_KEY`
set pointsize 0.5

N = `echo $GNUPLOT_N`

if (N==1) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`";

if (N==2) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA2`";

if (N==3) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA2`",	"test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`";

if (N==4) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`"; 

if (N==5) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using  ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`", "test5.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA5`"; 

if (N==6) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using  ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`", "test5.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA5`", "test6.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA6`"; 

if (N==7) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using  ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`", "test5.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA5`", "test6.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA6`", "test7.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA7`"; 

if (N==8) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using  ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`", "test5.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA5`", "test6.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA6`", "test7.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA7`", "test8.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA8`"; 

if (N==9) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using  ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`", "test5.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA5`", "test6.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA6`", "test7.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA7`", "test8.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA8`", "test9.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA9`";

if (N==10) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using  ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`", "test5.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA5`", "test6.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA6`", "test7.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA7`", "test8.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA8`", "test9.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA9`", "test10.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA10`";

if (N==11) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using  ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`", "test5.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA5`", "test6.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA6`", "test7.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA7`", "test8.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA8`", "test9.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA9`", "test10.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA10`", "test11.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA11`";

if (N==12) plot [0:`echo $GNUPLOT_XMAX`] [0:`echo $GNUPLOT_YMAX`] "test1.dat"  using ($1/1000):($4) title "`echo $GNUPLOT_DATA1`", "test2.dat" using  ($1/1000):($4) title "`echo $GNUPLOT_DATA2`", "test3.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA3`", "test4.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA4`", "test5.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA5`", "test6.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA6`", "test7.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA7`", "test8.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA8`", "test9.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA9`", "test10.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA10`", "test11.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA11`", "test12.dat" using ($1/1000):($4) title "`echo $GNUPLOT_DATA12`";

if (N>=13) plot [0:] [0:] "test1.dat"  using ($1/1000):($4) title "Wrong N";

