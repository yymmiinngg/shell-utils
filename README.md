# shell-utils
Shell 工具集

# 引入
在你的shell程序代码目录下，将shell-utils以子模块的形式添加到程序中
```
git submodule add git@github.com:yymmiinngg/shell-utils.git shell-utils
```

## 目录结构
假设你的shell程序目录为src
```
src
  |-- shell-utils
     |-- args-helper
  |-- .gitignore
  |-- .gitmodules
  |-- cmd1.sh
  |-- cmd2.sh
```

# args-helper

shell参数工具，帮助你快速提取自定义shell命令的参数。具体用法请直接参看args-helper中的注释内容

## 用法

在你的shell程序文件里加入如下代码，例如：demo.sh

```
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

# 显示帮助信息的参数
_ShowHelp_="--help"
# 显示版本信息的参数
_ShowVersion_="--version"
# 版本信息
_VersionInfo_="version: 1.0.1, copyright by yaoming (2019)"

# 引入工具文件
source `dirname $0`/shell-utils/args-helper

echo -------------------------------------------------------
# 输出版本信息
printVersion

echo -------------------------------------------------------
# 输出帮助信息
printHelp

echo -------------------------------------------------------
# 输出参数信息
printArgs
```

试试看效果吧，在shell中输入：
```
[root@local]# sh demo.sh -A -v -v -n 111 -s 222 000 
```
输出：
```
-------------------------------------------------------
version: 1.0.1, copyright by yaoming (2019)
-------------------------------------------------------
Usage: cat [OPTION]... [FILE]...
Concatenate FILE(s), or standard input, to standard output.

  -A, --show-all           equivalent to -vET
  -b, --number-nonblank    number nonempty output lines
  -e                       equivalent to -vE
  -E, --show-ends          display $ at end of each line
  -n, --number             number all output lines
  -s, --squeeze-blank      suppress repeated empty output lines
  -t                       equivalent to -vT
  -T, --show-tabs          display TAB characters as ^I
  -u                       (ignored)
  -v, --show-nonprinting   use ^ and M- notation, except for LFD and TAB
      --help               display this help and exit
      --version            output version information and exit

With no FILE, or when FILE is -, read standard input.

Examples:
  cat f - g  Output f's contents, then standard input, then g's contents.
  cat        Copy standard input to standard output.

Report cat bugs to bug-coreutils@gnu.org
GNU coreutils home page: <http://www.gnu.org/software/coreutils/>
General help using GNU software: <http://www.gnu.org/gethelp/>
For complete documentation, run: info coreutils 'cat invocation'
-------------------------------------------------------
OPTIONS:
    option > -s : 222
    option > -n : 111
SWITCHS:
    switch > -A : 1
    switch > -v : 2
PARAMS:
    param > 000
```
