#!/bin/bash

while getopts ":f:o:" o; do
    case "${o}" in
        f)
            FileName=${OPTARG}
            ;;
        o)
            OutputFile=${OPTARG}
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${s}" ] || [ -z "${p}" ]; then
    echo "The syntax is ./nochar.sh -f <domainslist.txt> -o <results.txt>"
fi

echo "FileName where domains are is set to ${FileName}"
echo "Your results will be in a file called ${OutputFile}"

touch output.txt

for i in $(cat "$FileName"); do
    content=$(curl --head --max-time 2 "{$i}")
    echo "<-------------------->" >> output.txt
    echo "$content" >> output.txt
done

cat output.txt | grep "HTTP" | cut -d " " -f 2 >> code.txt
sed 's/^/HTTP Response Code /' code.txt > code1.txt
cat output.txt | grep "Location:" >> output1.txt
cat output.txt | grep "Content-Type:" >> output2.txt
cat output.txt | grep "<-------------------->" >> output3.txt

paste -d'\n' code1.txt output1.txt output2.txt output3.txt > $OutputFile

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
cat $OutputFile | grep -C 3 "200"
cat $OutputFile | grep -C 3 "201"
cat $OutputFile | grep -C 3 "202"
cat $OutputFile | grep -C 3 "203"
cat $OutputFile | grep -C 3 "204"
cat $OutputFile | grep -C 3 "205"
cat $OutputFile | grep -C 3 "206"
cat $OutputFile | grep -C 3 "207"
cat $OutputFile | grep -C 3 "208"
cat $OutputFile | grep -C 3 "226"
echo "-----------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------"
echo "======================= RESPONSE CODES: 300 RANGE ================================="
echo "-----------------------------------------------------------------------------------"
cat $OutputFile | grep -C 3 "300"
cat $OutputFile | grep -C 3 "301"
cat $OutputFile | grep -C 3 "302"
cat $OutputFile | grep -C 3 "303"
cat $OutputFile | grep -C 3 "304"
cat $OutputFile | grep -C 3 "305"
cat $OutputFile | grep -C 3 "306"
cat $OutputFile | grep -C 3 "307"
cat $OutputFile | grep -C 3 "308"
echo "-----------------------------------------------------------------------------------"
echo "------------ ALL OTHER RESPONSE CODES AVAILABLE IN $OutputFile --------------------"
echo "-----------------------------------------------------------------------------------"
