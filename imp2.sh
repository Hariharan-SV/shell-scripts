add () {
    rollno=$1
    result=$(echo $rollno | grep -i -w -c "[0-9][0-9][a-z][a-z][0-9][0-9]")
    if [ $result -eq 1 ]
        then
        echo $* >> student.txt
        else
        echo 'invalid roll number'
    fi
}



remove (){
echo "edit"
   replace=$2
   rollno=$1
   #sed -i 's/'$1'/'$2'/' student.dat
   val=$(awk '/'$rollno'/ {print $3}' student.txt)
   awk '{if($1~/'$rollno'/)gsub(/'$val'/,'$replace',$3);print $0}' student.txt > t.txt
   cat t.txt > student.txt
   rm t.txt
#    awk '$1~/'$rollno'/ {$3='lol'; print $0}' student.txt >> student.txt
}

# display (){

# }

choice=6
while [ $choice -ne 0 ]
do
    echo -e '\n1.Add\n2.Display\n3.Remove\n4.Edit\n5.Sort\n0.Exit'
    read -p 'Enter choice:' choice
    case $choice in
    1)
        echo 'new record'
        read -p 'Enter rollno:' rollno
        read -p 'Enter name:' name
        # read -p 'Enter m1:' m1
        # read -p 'Enter m2:' m2
        # read -p 'Enter m3:' m3
        # read -p 'Enter m4:' m4
        # read -p 'Enter m5:' m5
        add $rollno $name 
        # $m1 $m2 $m3 $m4 $m5
    ;;
    2)
        
    ;;
    3)
    read -p 'Enter rollno:' rollno
        read -p 'Enter name:' name
    remove $rollno $name
    ;;
    4)
    ;;
    5)
    ;;
    esac
done
