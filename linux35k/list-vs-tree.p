# class collabed.model.mset.TreeLookup
# Computer: 127.0.1.1
# JVM: 1.6.0_16
# OS: Linux
# Edit Block: 100 Edits
# Maximum Memory: 865 MB
# Processors: 2
# editCnt, _blockTime, _insL, _Time, _insR, _Time, _extL, _Time, _extR, _Time, _delL, _Time, _delR, _Time, _status, _Time, _usedMemKB, _totalMemKB, inQ, outQ
#100	2	13	1	13	0	8	0	8	0	4	0	4	0	25	1	16033	59776	0	0

# Some line types
## using with lines
## using smooth csplines
## using smooth bezier
##set yrange restore;



set title "INSERT";
set xlabel "Current Edit Count (in thousands)";
set ylabel "Time (milliseconds)";
set term png;
set output "insert.png"
plot \
 "list.time" using ($1/1000):($4/$3)  title "Local Insert Time - List" 1, \
 "list.time" using ($1/1000):($6/$5)  title "Remote Insert Time - List" 2, \
 "tree.time" using ($1/1000):($4/$3)  title "Local Insert Time - Tree" 3, \
 "tree.time" using ($1/1000):($6/$5)  title "Remote Insert Time - Tree" 4;

set title "INSERT (Bezier)";
set xlabel "Current Edit Count (in thousands)";
set ylabel "Time (milliseconds)";
set term png;
set output "insertb.png"
plot \
 "list.time" using ($1/1000):($4/$3) smooth bezier title "Local Insert Time - List" 1, \
 "list.time" using ($1/1000):($6/$5) smooth bezier title "Remote Insert Time - List" 2, \
 "tree.time" using ($1/1000):($4/$3) smooth bezier title "Local Insert Time - Tree" 3, \
 "tree.time" using ($1/1000):($6/$5) smooth bezier title "Remote Insert Time - Tree" 4;



set title "DELETE";
set xlabel "Current Edit Count (in thousands)";
set ylabel "Time - (milliseconds)";
set term png;
set output "delete.png"
plot \
 "list.time" using ($1/1000):($12/$11)  title "Local Delete Time - List" 1, \
 "list.time" using ($1/1000):($14/$13)  title "Remote Delete Time - List" 2, \
 "tree.time" using ($1/1000):($12/$11)  title "Local Delete Time - Tree" 3, \
 "tree.time" using ($1/1000):($14/$13)  title "Remote Delete Time - Tree" 4;

set yrange [0:5]; # for ZOOMING b/c this has the greatest standard deviation
set title "DELETE (Bezier)";
set xlabel "Current Edit Count (in thousands)";
set ylabel "Time - (milliseconds)";
set term png;
set output "deleteb.png"
plot \
 "list.time" using ($1/1000):($12/$11) smooth bezier title "Local Delete Time - List" 1, \
 "list.time" using ($1/1000):($14/$13) smooth bezier title "Remote Delete Time - List" 2, \
 "tree.time" using ($1/1000):($12/$11) smooth bezier title "Local Delete Time - Tree" 3, \
 "tree.time" using ($1/1000):($14/$13) smooth bezier title "Remote Delete Time - Tree" 4;
set yrange [*:*];



set title "EXTEND";
set xlabel "Current Edit Count (in thousands)";
set ylabel "Time - (milliseconds)";
set term png;
set output "extend.png"
plot \
 "list.time" using ($1/1000):($8/$7)  title "Local Extend Time - List" 1, \
 "list.time" using ($1/1000):($10/$9)  title "Remote Extend Time - List" 2, \
 "tree.time" using ($1/1000):($8/$7)  title "Local Extend Time - Tree" 3, \
 "tree.time" using ($1/1000):($10/$9)  title "Remote Extend Time - Tree" 4;

set title "EXTEND (Bezier)";
set xlabel "Current Edit Count (in thousands)";
set ylabel "Time - (milliseconds)";
set term png;
set output "extendb.png"
plot \
 "list.time" using ($1/1000):($8/$7) smooth bezier title "Local Extend Time - List" 1, \
 "list.time" using ($1/1000):($10/$9) smooth bezier title "Remote Extend Time - List" 2, \
 "tree.time" using ($1/1000):($8/$7) smooth bezier title "Local Extend Time - Tree" 3, \
 "tree.time" using ($1/1000):($10/$9) smooth bezier title "Remote Extend Time - Tree" 4;



set title "MEMORY USAGE";
set xlabel "Current Edit Count (in thousands)";
set ylabel "Memory (MB)";
set term png;
set output "memory.png";
plot \
 "list.time" using ($1/1000):($17/1024)  title "Used Memory - List" 1, \
 "list.time" using ($1/1000):($18/1024)  title "Total Memory - List" 2, \
 "tree.time" using ($1/1000):($17/1024)  title "Used Memory - Tree" 3, \
 "tree.time" using ($1/1000):($18/1024)  title "Total Memory - Tree" 4;

set title "MEMORY USAGE (Bezier)";
set xlabel "Current Edit Count (in thousands)";
set ylabel "Memory (MB)";
set term png;
set output "memoryb.png"
plot \
 "list.time" using ($1/1000):($17/1024) smooth bezier title "Used Memory - List" 1, \
 "list.time" using ($1/1000):($18/1024) smooth bezier title "Total Memory - List" 2, \
 "tree.time" using ($1/1000):($17/1024) smooth bezier title "Used Memory - Tree" 3, \
 "tree.time" using ($1/1000):($18/1024) smooth bezier title "Total Memory - Tree" 4;



set title "Edit Range Per Block";
set xrange [0:35];
set xlabel "";
set ylabel "Edits";
set term png;
set output "editrange.png";
plot \
 "list.time" using (1):3  title "Local Inserts - List" 1, \
 "tree.time" using (2):3  title "Local Inserts - Tree" 2, \
 "list.time" using (3):5  title "Remote Inserts - List" 3, \
 "tree.time" using (4):5  title "Remote Inserts - Tree" 4, \
\
 "list.time" using (6):11  title "Local Deletes - List" 5, \
 "tree.time" using (7):11  title "Local Deletes - Tree" 6, \
 "list.time" using (8):13  title "Remote Deletes - List" 7, \
 "tree.time" using (9):13  title "Remote Deletes - Tree" 8, \
\
 "list.time" using (11):7  title "Local Extends - List" 9, \
 "tree.time" using (12):7  title "Local Extends - Tree" 10, \
 "list.time" using (13):9  title "Remote Extends - List" 11, \
 "tree.time" using (14):9  title "Remote Extends - Tree" 12, \
\
 "list.time" using (16):15  title "Status Checks - List" 13, \
 "tree.time" using (17):15  title "Status Checks - Tree" 14;
set xrange [*:*];



set title "Edit Totals";
set xrange [0:35];
set xlabel "";
set ylabel "Edits";
set term png;
set output "editsum.png";
plot \
 "listsum.time" using (1):3  title "Local Inserts - List" 1, \
 "treesum.time" using (2):3  title "Local Inserts - Tree" 2, \
 "listsum.time" using (3):5  title "Remote Inserts - List" 3, \
 "treesum.time" using (4):5  title "Remote Inserts - Tree" 4, \
\
 "listsum.time" using (6):11  title "Local Deletes - List" 5, \
 "treesum.time" using (7):11  title "Local Deletes - Tree" 6, \
 "listsum.time" using (8):13  title "Remote Deletes - List" 7, \
 "treesum.time" using (9):13  title "Remote Deletes - Tree" 8, \
\
 "listsum.time" using (11):7  title "Local Extends - List" 9, \
 "treesum.time" using (12):7  title "Local Extends - Tree" 10, \
 "listsum.time" using (13):9  title "Remote Extends - List" 11, \
 "treesum.time" using (14):9  title "Remote Extends - Tree" 12, \
\
 "listsum.time" using (16):15  title "Status Checks - List" 13, \
 "treesum.time" using (17):15  title "Status Checks - Tree" 14, \
\
 "listsum.time" using (18):1  title "Total Edits - List" 15, \
 "treesum.time" using (19):1  title "Total Edits - Tree" 16;
set xrange [*:*];



set title "Time Totals";
set xrange [0:35];
set xlabel "";
set ylabel "Excecution Time";
set term png;
set output "timesum.png";
plot \
 "listsum.time" using (1):4  title "Local Inserts - List" 1, \
 "treesum.time" using (2):4  title "Local Inserts - Tree" 2, \
 "listsum.time" using (3):6  title "Remote Inserts - List" 3, \
 "treesum.time" using (4):6  title "Remote Inserts - Tree" 4, \
\
 "listsum.time" using (6):12  title "Local Deletes - List" 5, \
 "treesum.time" using (7):12  title "Local Deletes - Tree" 6, \
 "listsum.time" using (8):14  title "Remote Deletes - List" 7, \
 "treesum.time" using (9):14  title "Remote Deletes - Tree" 8, \
\
 "listsum.time" using (11):8  title "Local Extends - List" 9, \
 "treesum.time" using (12):8  title "Local Extends - Tree" 10, \
 "listsum.time" using (13):10  title "Remote Extends - List" 11, \
 "treesum.time" using (14):10  title "Remote Extends - Tree" 12, \
\
 "listsum.time" using (16):16  title "Status Checks - List" 13, \
 "treesum.time" using (17):16  title "Status Checks - Tree" 14, \
\
 "listsum.time" using (18):2  title "Combined Time - List" 15, \
 "treesum.time" using (19):2  title "Combined Time - Tree" 16;
set xrange [*:*];


