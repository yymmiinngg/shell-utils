#!/bin/sh

. `dirname $0`/../lib/string-utils

echo ">$( STR_GetLeft "a|b|c" "" )<"
echo ">$( STR_GetLeft "a|b|c" "m" )<"
echo ">$( STR_GetLeft "a|b|c" "|" )<"
echo 
echo ">$( STR_GetLeftOutter "a|b|c" "" )<"
echo ">$( STR_GetLeftOutter "a|b|c" "m" )<"
echo ">$( STR_GetLeftOutter "a|b|c" "|" )<"
echo 
echo ">$( STR_GetRight "a|b|c" "" )<"
echo ">$( STR_GetRight "a|b|c" "m" )<"
echo ">$( STR_GetRight "a|b|c" "|" )<"
echo 
echo ">$( STR_GetRightOutter "a|b|c" "" )<"
echo ">$( STR_GetRightOutter "a|b|c" "m" )<"
echo ">$( STR_GetRightOutter "a|b|c" "|" )<"
echo 
echo ">$( STR_GetSection "a|b|c" "" "" )<"
echo ">$( STR_GetSection "a|b|c" "m" "x" )<"
echo ">$( STR_GetSection "a|b|c" "c" "b" )<"
echo ">$( STR_GetSection "a|b|c" "|" "|" )<"
echo 
echo ">$( STR_Trim "\ta|b|c abc      " )<"
echo ">$( STR_Trim "\ta|b|c abc" "abc" )<"
