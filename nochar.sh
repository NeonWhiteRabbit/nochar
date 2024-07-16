#!/bin/bash

echo "What is the domain file?"
read dom
touch output.txt

for i in $(cat "$dom"); do
    content=$(curl --head "{$i}")
    echo "<-------------------->" >> output.txt
    echo "$content" >> output.txt
done

cat output.txt | grep "HTTP" | cut -d " " -f 2 >> code.txt
sed 's/^/HTTP Response Code /' code.txt > code1.txt
cat output.txt | grep "Location:" >> output1.txt
cat output.txt | grep "Content-Type:" >> output2.txt
cat output.txt | grep "<-------------------->" >> output3.txt

paste -d'\n' code1.txt output1.txt output2.txt output3.txt > results.txt

rm output1.txt output2.txt output3.txt code.txt output.txt code1.txt

echo "-----------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------"
echo "-------------========== noChar - check content types - ==============--------------"
echo "-----------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------"
echo "======================= RESPONSE CODES: 200 RANGE ================================="
echo "-----------------------------------------------------------------------------------"
cat results.txt | grep -C 3 "200"
cat results.txt | grep -C 3 "201"
cat results.txt | grep -C 3 "202"
cat results.txt | grep -C 3 "203"
cat results.txt | grep -C 3 "204"
cat results.txt | grep -C 3 "205"
cat results.txt | grep -C 3 "206"
cat results.txt | grep -C 3 "207"
cat results.txt | grep -C 3 "208"
cat results.txt | grep -C 3 "226"
echo "-----------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------"
echo "======================= RESPONSE CODES: 300 RANGE ================================="
echo "-----------------------------------------------------------------------------------"
cat results.txt | grep -C 3 "300"
cat results.txt | grep -C 3 "301"
cat results.txt | grep -C 3 "302"
cat results.txt | grep -C 3 "303"
cat results.txt | grep -C 3 "304"
cat results.txt | grep -C 3 "305"
cat results.txt | grep -C 3 "306"
cat results.txt | grep -C 3 "307"
cat results.txt | grep -C 3 "308"
echo "-----------------------------------------------------------------------------------"
echo "------------ ALL OTHER RESPONSE CODES AVAILABLE IN results.txt --------------------"
echo "-----------------------------------------------------------------------------------"
