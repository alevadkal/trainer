#! /bin/bash
SCORE=0
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

FILE="$(date --iso-8601=seconds| sed 's/:/-/g').log"

echo " Будет задана последовательность из 50 примеров на множение"


for i in $(seq 1 50); do
    a=$(($RANDOM%10))
    b=$(($RANDOM%10))
    echo
    echo "Задание $i/50"
    echo -n "$a*$b="
    read result
    
    echo "$a*$b=$result" >> $FILE
    
    if [ "$result" == $(($a*$b)) ]; then
        SCORE=$(($SCORE+1));
        echo -e "${GREEN}Правильно!${ENDCOLOR}"
        continue;
    fi
    echo -e "${RED}Неправильно!${ENDCOLOR} $a*$b=${GREEN}$(($a*$b))${ENDCOLOR} но вы ввели ${RED}$result${ENDCOLOR}"
done

echo "Ваш результат $SCORE/50"
echo "$SCORE/50" >> $FILE
md5sum  $FILE >> $FILE.sum 
if [ "$SCORE" = 50 ]; then
    echo -e "${GREEN} Поздравляю вы прошли задание успешно!${ENDCOLOR}" 
else
    echo -e "${RED} Увы но задание не пройдено. Попробуйте ещё раз! ${ENDCOLOR}"
fi