#!/bin/sh

# ###########################################################
# 使用前配置 
AH_ArgsMeta="
# For example cat:
# 
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
?   -w, --hello-world       ### output hello world and exit
?       --help              ### display this help and exit
?       --version           ### output version information and exit
# With no FILE, or when FILE is -, read standard input.
#
# Examples:
#   cat f - g  Output f's contents, then standard input, then g's contents.
#   cat        Copy standard input to standard output.
#
# Report cat bugs to bug-coreutils@gnu.org
# GNU coreutils home page: <http://www.gnu.org/software/coreutils/>
# General help using GNU software: <http://www.gnu.org/gethelp/>
# For complete documentation, run: info coreutils 'cat invocation'"  # 参数元数据配置
AH_ShowHelp="--help"  # 输出帮助信息的指令参数(可省略)
AH_DefaultHelpMeta="no"  # 因为AH_ArgsMeta中已经配置了--help和--version，无须使用默认配置
AH_ShowVersion="--version"  # 输出版本信息的指令参数（可省略）
AH_VersionInfo="version: 1.0.1, copyright by yaoming (2019)"  # 自定义版本信息（可省略）
AH_StrictParam="no"  # 不使用严格参数（支持以"-"开头的参数）
AH_LeastParamCount=0  # 参数数量不得少于1个（0表示不验证最少数量）

# ###########################################################
# 引入工具文件（这里按实际目录结构引入）
source `dirname $0`/../lib/args-helper 

# ###########################################################
# 使用
if [ ${AH_SWITCHS['--hello-world']} ]; then
    echo -------------------------------------------------------
    AH_PrintVersion # 输出版本信息

    echo -------------------------------------------------------
    AH_PrintHelp    # 输出帮助信息

    echo -------------------------------------------------------
    AH_PrintArgs    # 输出参数信息
fi
