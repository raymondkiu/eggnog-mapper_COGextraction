#!/bin/bash
if [ $# -lt 1 ] ; then
    echo ""
    echo "usage: extract_COG.sh annotation_file.annotations ..|| *.emapper.annotations"
    echo "sort COG classes"
    echo ""
    exit 0
fi

filear=${@};
for i in ${filear[@]}

do

awk -F "\t" '{print $11}' $i > $i-COG-unsorted
sort $i-COG-unsorted > $i-COG-sorted

for j in A B C D E F G H I J K L M N O P Q T U X Y Z R S W V;do grep $j $i-COG-sorted|wc -l >> $i-COG-num;done
for j in A B C D E F G H I J K L M N O P Q T U X Y Z R S W V;do echo $j >> $i-COG-let;done

paste $i-COG-let $i-COG-num > $i-COG-final
sed 's/\t/,/g' $i-COG-final > $i-COG-final.csv

rm $i-COG-let
rm $i-COG-num
rm $i-COG-final
rm $i-COG-sorted
rm $i-COG-unsorted

done
