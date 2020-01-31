Insert:
Use same echo $var>>filename as it has no insert and follows the same pattern

Search:
awk -F 'FieldSeperator'  '$x~/PATTERN/ {print $0}' filename
will print line matching the PATTERN in x th column

awk -F 'FieldSeperator'  '~/PATTERN/ {print $0}' filename
will print line matching the PATTERN

Search: and Replace:
awk -F 'FieldSeperator'  '$x~/PATTERN/  {gsub(/src/,replacement,$x)}1' filename
will search for PATTERN in x th column and replaces src by replacement in x th column

Calculate sum of one column based on unique values of another column:
awk -F 'FieldSeperator' '{a[$x] += $y} END{for (i in a) print i, a[i]}' filename.txt
searches for unique values of x and calculates sum of yth column

Delete
awk -F 'FieldSeperator'  '$x!~/PATTERN/ ' filename
will delete line matching the PATTERN in x th column

Sort:
sort -tFieldSeperator -kx,xn filename
will sort n th column of file if it is a number, if it is a text donot use n

Find Min and Max
awk -F 'FieldSeperator' 'BEGIN{a=100}  {if ($x<a) a=$x} END{print a}' filename
awk -F 'FieldSeperator' 'BEGIN{a=0}  {if ($x>a) a=$x} END{print a}' filename

Any modification made in search and replace or delete will not be stored in original file so send it to the temp file and rename it and reuse it
