# shell-utils
Shell 工具集

当前支持 centos-6.x 和 centos-7.x ，暂不支持 macos 系统，欢迎提交更多的适配信息！

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
#!/bin/sh
# ###########################################################
# 使用前配置 
_ArgsMeta_="
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
_ShowHelp_="--help"  # 输出帮助信息的指令参数(可省略)
_DefaultHelpMeta_="no"  # 因为_ArgsMeta_中已经配置了--help和--version，无须使用默认配置
_ShowVersion_="--version"  # 输出版本信息的指令参数（可省略）
_VersionInfo_="version: 1.0.1, copyright by yaoming (2019)"  # 自定义版本信息（可省略）
_StrictParam_="no"  # 不使用严格参数（支持以"-"开头的参数）
_LeastParamCount_=0  # 参数数量不得少于1个（0表示不验证最少数量）

# ###########################################################
# 引入工具文件（这里按实际目录结构引入）
source `dirname $0`/shell-utils/args-helper

# ###########################################################
# 使用
if [ ${_SWITCHS_['--hello-world']} ]; then
    echo -------------------------------------------------------
    _PrintVersion_ # 输出版本信息

    echo -------------------------------------------------------
    _PrintHelp_    # 输出帮助信息

    echo -------------------------------------------------------
    _PrintArgs_    # 输出参数信息
fi
```

试试看效果吧

```
[root@local]# sh demo.sh -A -v -v -n 111 -s 222 000 --hello-world
```
输出：

```
-------------------------------------------------------
version: 1.0.1, copyright by yaoming (2019)
-------------------------------------------------------
For example cat:

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
  -w, --hello-world        output hello world and exit
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
_OPTIONS_:
  ${_OPTIONS_['-s']} : 222
  ${_OPTIONS_['-n']} : 111
  ${_OPTIONS_['--number']} : 111
  ${_OPTIONS_['--squeeze-blank']} : 222
_SWITCHS_:
  ${_SWITCHS_['-A']} : 1
  ${_SWITCHS_['-w']} : 1
  ${_SWITCHS_['-v']} : 2
  ${_SWITCHS_['--show-nonprinting']} : 2
  ${_SWITCHS_['--hello-world']} : 1
  ${_SWITCHS_['--show-all']} : 1
_PARAMS_:
  ${_PARAMS_[0]} : 000
```

输出帮助信息

```
[root@local]# sh demo.sh --help
```
输出：

```
For example cat:

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
  -w, --hello-world        output hello world and exit
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
```

输出版本信息

```
[root@local]# sh demo.sh --version
```
输出：
```
version: 1.0.1, copyright by yaoming (2019)
```