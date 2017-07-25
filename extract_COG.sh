awk -F "\t" '{print $11}' *.emapper.annotations > COG_unsorted
sort COG_unsorted > COG_sorted

for j in A B C D E F G H I J K L M N O P Q T U Y Z R S;do grep $j COG_sorted|wc -l >> COG_num;done
for j in A B C D E F G H I J K L M N O P Q T U Y Z R S;do echo $j >> COG_let;done

paste COG_let COG_num > COG_final
sed 's/\t/,/g' COG_final > COG_final.csv

rm COG_let
rm COG_num
rm COG_final
rm COG_sorted
rm COG_unsorted
