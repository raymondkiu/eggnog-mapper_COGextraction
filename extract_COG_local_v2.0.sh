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

grep -v "#" $i |awk -F "\t" '{print $11}'|sort > $i-COG-sorted  #11th column - it can differ, change this if you find different column is assigned for COG classes

for j in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;do grep $j $i-COG-sorted|wc -l >> $i-COG-num;done
for j in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;do echo $j >> $i-COG-let;done

sum=0; while read num; do ((sum += num)); done < $i-COG-num; echo $sum >> $i-COG-num  #this is to sum up all the categories number, comment this if you don't want to know the sum
echo sum >> $i-COG-let  #comment this if you are summing up the category letters

paste $i-COG-let $i-COG-num > $i-COG-final
sed 's/\t/,/g' $i-COG-final > $1-COG-final.csv

rm $i-COG-sorted
rm $i-COG-let
rm $i-COG-num
rm $i-COG-final

done
