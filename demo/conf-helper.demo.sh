#!/bin/sh

CH_ConfigsName="myConfigs"
CH_ConfigsFile="config.cnf"

# 执行库脚本
source `dirname $0`/../lib/conf-helper
eval $( echo "__________=\${!$CH_ConfigsName[@]}" )

echo Config name: $CH_ConfigsName
echo Config file: $CH_ConfigsFile
echo Config items: ${__________[*]}

echo $CH_ConfigsName:

for key in ${__________[*]}; do
    eval $( echo "value=\${$CH_ConfigsName[$key]}" )
    printf "  \${$CH_ConfigsName[$key]} = $value \n"
done