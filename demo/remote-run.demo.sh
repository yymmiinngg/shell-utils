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