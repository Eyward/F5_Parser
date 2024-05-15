#/bin/sh
#  W.B

NEWLINE=""
MVVV=""

tmsh  show ltm virtual detail recursive | grep -E "Ltm::Virtual|Ltm::Pool" | sed 's/Ltm::Virtual Server:/NAME/g' | sed 's/| Ltm::Pool:/POOL/g'|sed 's/| Ltm::Pool Member:/MEMBER/g'|sed 's/| Ltm::Virtual Address:/IP/g' 
cat IN1 | while read LINE ; do
echo $LINE | grep NAME
if [ $? -eq 0 ]
        then
        MVVV=`echo $LINE|awk '{print $NF}'`
        NEWLINE=`echo $NEWLINE $MVVV ";"`
fi
echo $LINE|grep POOL
if [ $? -eq 0 ]
        then
        MVVV=`echo $LINE|awk '{print $NF}'`
        NEWLINE=`echo $NEWLINE $MVVV ";"`
fi
echo $LINE|grep MEMBER
if [ $? -eq 0 ]
        then
        MVVV=`echo $LINE|awk '{print $NF}'`
        NEWLINE=`echo $NEWLINE $MVVV ";"`
fi
echo $LINE|grep IP
if [ $? -eq 0 ]
        then
        MVVV=`echo $LINE|awk '{print $NF}'`
        NEWLINE=`echo $NEWLINE $MVVV ";"`
        echo $NEWLINE >> OUT1
        NEWLINE=""
fi
done
