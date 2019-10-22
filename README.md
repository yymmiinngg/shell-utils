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
|--shell-utils
   |--bin
      |--cssh
   |--lib
      |--args-helper
      |--remote-run
|--.gitignore
|--.gitmodules
|--cmd1.sh
|--cmd2.sh
```

# 库

## args-helper

shell参数工具，帮助你快速提取自定义shell命令的参数。具体用法请直接参看args-helper中的注释内容。
例如：args-helper.demo.sh

```
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
```

### 一个示例

```
[root@local]# sh demo/args-helper.demo.sh -A -v -v -n 111 -s 222 000 --hello-world
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
AH_OPTIONS:
  ${AH_OPTIONS['--number']} : 111
  ${AH_OPTIONS['-s']} : 222
  ${AH_OPTIONS['-n']} : 111
  ${AH_OPTIONS['--squeeze-blank']} : 222
AH_SWITCHS:
  ${AH_SWITCHS['--show-nonprinting']} : 2
  ${AH_SWITCHS['-A']} : 1
  ${AH_SWITCHS['-w']} : 1
  ${AH_SWITCHS['-v']} : 2
  ${AH_SWITCHS['--hello-world']} : 1
  ${AH_SWITCHS['--show-all']} : 1
AH_PARAMS:
  ${AH_PARAMS[0]} : 000
```

### 输出帮助信息

```
[root@local]# sh demo/args-helper.demo.sh --help
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

### 输出版本信息

```
[root@local]# sh demo/args-helper.demo.sh --version
```

输出：

```
version: 1.0.1, copyright by yaoming (2019)
```

## remote-run

shell集群批执行工具，帮助你快速开发集群执行命令。
例如：remote-run.demo.sh

```
#!/bin/sh

echo "正常的示例 ----------------------------------------------------"
# ssh远程执行的用户
RR_User="root"
 # 远程执行的命令，这里也可以是脚本文件
RR_Command="
cd ~/.ssh
ls -l 
"                   
# 批处理的主机（将在这些主机上运行命令），必须提前做好无密码连接（密钥连接）
RR_Hosts="127.0.0.1 127.0.0.1" # 这里为了方面演示使用了两个相同的host
# 如果其中一台主机执行出错了则中断执行
RR_NoBreak="no"

# 执行库脚本
source `dirname $0`/../lib/remote-run

echo
echo "异常的示例 ----------------------------------------------------"
RR_User="root"
RR_Command="lls -l"                   
RR_Hosts="127.0.0.1 127.0.0.1"
RR_NoBreak="no"

# 执行库脚本
source `dirname $0`/../lib/remote-run
```
### 一个示例

```
[root@local]# sh demo/remote-run.demo.sh
```

输出：

```
正常的示例 ----------------------------------------------------
######## run script on root@127.0.0.1 beginning ...
total 16
-rw-r--r--. 1 root root  408 Oct 22 11:17 authorized_keys
-rw-------. 1 root root 1675 Oct 14 21:08 id_rsa
-rw-r--r--. 1 root root  408 Oct 14 21:08 id_rsa.pub
-rw-r--r--. 1 root root  696 Oct 22 19:21 known_hosts
======== run script on root@127.0.0.1 success
######## run script on root@127.0.0.1 beginning ...
total 16
-rw-r--r--. 1 root root  408 Oct 22 11:17 authorized_keys
-rw-------. 1 root root 1675 Oct 14 21:08 id_rsa
-rw-r--r--. 1 root root  408 Oct 14 21:08 id_rsa.pub
-rw-r--r--. 1 root root  696 Oct 22 19:21 known_hosts
======== run script on root@127.0.0.1 success

异常的示例 ----------------------------------------------------
######## run script on root@127.0.0.1 beginning ...
-bash: line 1: lls: command not found
======== run script on root@127.0.0.1 fail
======== breaked at root@127.0.0.1
```

# 工具

## cssh

一个用于在集群里完成批量执行的工具。使用前先把shell-utils/bin加入环境变量PATH，或者使用相对路径。

### 查看帮助

```
[root@local]# cssh --help
```

输出

```
Login SSH and run command for every hosts.
  -u, --username       login username.
  -s, --command-file   command file to run on every hosts.
  -h, --hosts-file     hosts file, like:
                       192.168.1.1
                       192.168.1.2
                       192.168.1.3
  -n, --no-break       no break when error in a host
helps:
  --help       display this help and exit
  --version    output version information and exit
```

### 一个示例

```
[root@local]# cssh -u root "ls ~/.ssh -l" -h "127.0.0.1 127.0.0.1"        
```

输出：

```
######## run script on root@127.0.0.1 beginning ...
total 16
-rw-r--r--. 1 root root  408 Oct 22 11:17 authorized_keys
-rw-------. 1 root root 1675 Oct 14 21:08 id_rsa
-rw-r--r--. 1 root root  408 Oct 14 21:08 id_rsa.pub
-rw-r--r--. 1 root root  696 Oct 22 19:21 known_hosts
======== run script on root@127.0.0.1 success
######## run script on root@127.0.0.1 beginning ...
total 16
-rw-r--r--. 1 root root  408 Oct 22 11:17 authorized_keys
-rw-------. 1 root root 1675 Oct 14 21:08 id_rsa
-rw-r--r--. 1 root root  408 Oct 14 21:08 id_rsa.pub
-rw-r--r--. 1 root root  696 Oct 22 19:21 known_hosts
======== run script on root@127.0.0.1 success
```

### 异常中断

```
[root@local]# cssh -u root "lsss ~/.ssh -l" "127.0.0.1 127.0.0.1"
```

输出：

```
######## run script on root@127.0.0.1 beginning ...
-bash: line 1: lsss: command not found
======== run script on root@127.0.0.1 fail
======== breaked at root@127.0.0.1
```

### 忽略异常

```
[root@local]# cssh -u root "lsss ~/.ssh -l" -h "127.0.0.1 127.0.0.1" -n
```

输出：

```
######## run script on root@127.0.0.1 beginning ...
-bash: line 1: lsss: command not found
======== run script on root@127.0.0.1 fail
######## run script on root@127.0.0.1 beginning ...
-bash: line 1: lsss: command not found
======== run script on root@127.0.0.1 fail
```

