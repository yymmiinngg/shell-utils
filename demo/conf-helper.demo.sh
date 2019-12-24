#!/bin/sh

CH_ConfigName="myConfig"
CH_ConfigFile="config.cnf"

# 执行库脚本
. `dirname $0`/../lib/conf-helper
eval "configKeys=\${!$CH_ConfigName[@]}"

echo Config name: $CH_ConfigName
echo Config file: $CH_ConfigFile
echo Config items: ${configKeys[*]}

echo $CH_ConfigName:

for key in ${configKeys[*]}; do
    eval "value=\${$CH_ConfigName[$key]}"
    echo "  \${$CH_ConfigName[\"$key\"]} = $value"
done