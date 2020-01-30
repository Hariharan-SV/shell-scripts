#!/bin/bash

add () {
	rollno=$1
	name=$2
	shift 2
	marks=$*
	length=$#
	flag=0

	while [ $flag -eq 0  ]
	do
		cd check
		mkdir $rollno
		flag=$(ls -1|grep '[0-9][0-9][a-zA-Z][a-zA-Z][0-9][0-9]$'|wc -l)
		if [ $flag -eq 1 ]
		then
			flag=1
			rm -r $rollno
			cd ..
			break
		fi
		rm -r $rollno
		cd ..
		read -p "Invalid rollno. Enter the rollno again:- " rollno
	done

	flag=0
	while [ $flag -eq 0 ]
	do
		echo Checking $name
		if [[ $name =~ [0-9] ]]
		then
			echo "Name contains number"
			read -p "Enter the name again :- " name
		else
	      		flag=1
   		fi

	done

	while [ $length -ne 5  ]
	do
		echo "Invalid number of arguments for marks.Enter again"
		read -p "Enter your marks again :- " marks
		length=0
		for i in $marks
		do
			length=$((length+1))
		done
	done

	newmarks=$(echo "")
	echo $rollno $name $marks
	for i in $marks
	do
		if [ $i -eq $i 2>/dev/null -a $i -ge 0 -a $i -le 100 ]
		then
			echo $i
		else
			flag=0
			while [ $flag -eq 0 ]
			do
				read -p 'The mark '$i' is invalid. Now enter again :- ' value
				i=$value
				if [ $i -eq $i 2>/dev/null -a $i -ge 0 -a $i -le 100  ]
		                then
					flag=1
				fi
			done
		fi
		newmarks=$(echo $newmarks,$i)
	done
	echo $rollno,$name$newmarks >> student.dat

}

remove () {
	rollno=$1
	awk -F ',' '!/'$rollno'/ {print $0}' student.dat >newbook.dat
	mv newbook.dat student.dat
}

edit () {   echo "edit"
   replace=$1
   rollno=$2
   #sed -i 's/'$1'/'$2'/' student.dat
   # Use 6 switch case statements to edit here rollno,name,5 subject marks
	# Here you can change for 3rd column only
   awk -F ',' '$1~/'$rollno'/{$3='$replace'; print $0}' student.dat
}

sort () {
	sort -t, -k1 student.dat
}

print () {
   #echo "print"
   echo -e '\n'PSG COLLEGE OF TECHNOLOGY
   echo -e `date +%d:%m:%y`
   awk -F ',' 'BEGIN{OFS=" ";} {total=$3+$4+$5+$6+$7} {print NR,$1,$2,$3,$4,$5,$6,$7,total}' student.dat
   echo -e '\n' Total
   awk -F ',' '{if ($3 >=35) msum+=$3} {if ($4 >=35) psum+=$4}{if ($5 >=35) csum+=$5}{if ($6 >=35) cssum+=$6}{if ($7 >=35) bsum+=$7}END{print msum,psum,csum,cssum,bsum}' student.dat
   echo -e '\n' Average
   awk -F ',' '{if ($3 >=35) msum+=$3} {if ($4 >=35) psum+=$4}{if ($5 >=35) csum+=$5}{if ($6 >=35) cssum+=$6}{if ($7 >=35) bsum+=$7}END{print msum/NR,psum/NR,csum/NR,cssum/NR,bsum/NR}' student.dat
}

choice=1
echo 'Student data management'
while [ $choice -ne 0  ]
do
	echo -e '\n\t'1.Add'\n\t'2.remove'\n\t'3.Edit'\n\t'4.Sort'\n\t'5.Print'\n\t'6.Exit
	read -p "Enter your choice : " choice
	case $choice in
	1)
		echo "Add"
		read -p "Enter rollno :- " rollno
		read -p "Enter name   :- " name
		read -p "Enter marks for 5 subjects :- " marks
		add $rollno $name $marks
	;;
	2)
		echo "Remove"
		read -p "Enter the roll number you want to remove" rollno
	        remove $rollno

	;;
	3)
		echo "Edit"
		read -p "Enter the rollno" rollno
		read -p "Enter the word to be replaced" replace
		edit replace rollno
	;;
	4)
		echo "Sorting..."
		sort
	;;
	5)
		echo "Printing..."
		print
	;;
	6)
		choice=0
	;;
	esac
done
