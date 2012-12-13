## Needed Files: list.time and tree.time
#awk '{sum=sum+$2; print $1,sum}' infile > outfile
awk '{bt=bt+$2; li=li+$3; lit=lit+$4; ri=ri+$5; rit=rit+$6;le=le+$7; let=let+$8; re=re+$9; ret=ret+$10; ld=ld+$11; ldt=ldt+$12; rd=rd+$13; rdt=rdt+$14; sc=sc+$15; sct=sct+$16; print $1,bt,li,lit,ri,rit,le,let,re,let,ld,ldt,rd,rdt,sc,sct}' tree.time > treesum.time
awk '{bt=bt+$2; li=li+$3; lit=lit+$4; ri=ri+$5; rit=rit+$6;le=le+$7; let=let+$8; re=re+$9; ret=ret+$10; ld=ld+$11; ldt=ldt+$12; rd=rd+$13; rdt=rdt+$14; sc=sc+$15; sct=sct+$16; print $1,bt,li,lit,ri,rit,le,let,re,let,ld,ldt,rd,rdt,sc,sct}' list.time > listsum.time

gnuplot list-vs-tree.p
#gnuplot benchmark.p
#gnuplot -persist tmp.p

eog editsum.png
