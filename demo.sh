#!/bin/sh

# 配置参数元数据
_ArgsMeta_="
# Usage: cat [OPTION]... [FILE]...
# Concatenate FILE(s), or standard input, to standard output.
#
?   -A, --show-all          ### equivalent to -vET
+   -b, --number-nonblank   ### number nonempty output lines
?   -e                      ### equivalent to -vE
?   -E, --show-ends         ### display $ at end of each line
+   -n, --number            ### number all output lines
+   -s, --squeeze-blank     ### suppress repeated empty output lines
?   -t                      ### equivalent to -vT
?   -T, --show-tabs         ### display TAB characters as ^I
?   -u                      ### (ignored)
?   -v, --show-nonprinting  ### use ^ and M- notation, except for LFD and TAB
?       --help              ### display this help and exit
?       --version           ### output version information and exit
#
# With no FILE, or when FILE is -, read standard input.
#
# Examples:
#   cat f - g  Output f's contents, then standard input, then g's contents.
#   cat        Copy standard input to standard output.
#
# Report cat bugs to bug-coreutils@gnu.org
# GNU coreutils home page: <http://www.gnu.org/software/coreutils/>
# General help using GNU software: <http://www.gnu.org/gethelp/>
# For complete documentation, run: info coreutils 'cat invocation'
"

# 版本信息
_VersionInfo_="version: 1.0.1, copyright by yaoming (2019)"

# 引入工具文件
source args-helper

echo -------------------------------------------------------
# 输出版本信息
printVersion

echo -------------------------------------------------------
# 输出帮助信息
printHelp

echo -------------------------------------------------------
# 输出参数信息
printArgs