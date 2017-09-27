                                                               awk
文本分析，依次对每一行进行处理，然后输出
1、打印print

# last打印最近登录的5个账号
# print $1 表示输出第一行
# $0 表示输出所有字段
last -n 5 | awk '{print $1}'
>>root
>>root

2、指定分隔符
# -F : 表示按照 : 分隔
# 然后再执行{} 里的动作
# 将第一列和第7列打印，并用\t分隔
awk -F ':' '{print $1"\t"$7}' /etc/passwd

3、BEGIN和END
# 先分隔，然后执行BEGIN
# 在执行 {print $1","$7}
# 最后执行END
awk  -F ':'  'BEGIN {print "name,shell"}  {print $1","$7} END {print "blue,/bin/nosh"}' /etc/passwd
>>name,shell
>>root,/bin/bash
>>blue,/bin/nosh

4、匹配模式
# / 
# 找到root的行后，打印第7列
awk -F: '/root/{print $7}' /etc/passwd
>>/bin/bash
>>/sbin/nologin

# 找到root的所有行，并且全部输出，应为没有指定执行命令{}
awk -F: '/root/' /etc/passwd
>>root:x:0:0:root:/root:/bin/bash

5、内置变量
#ARGC               命令行参数个数
#ARGV               命令行参数排列
#ENVIRON            支持队列中系统环境变量的使用
#FILENAME           awk浏览的文件名
#FNR                浏览文件的记录数
#FS                 设置输入域分隔符，等价于命令行 -F选项
#NF                 浏览记录的域的个数
#NR                 已读的记录数
#OFS                输出域分隔符
#ORS                输出记录分隔符
#RS                 控制记录分隔符

awk  -F ':'  '{print "filename:" FILENAME ",linenumber:" NR ",columns:" NF ",linecontent:"$0}' /etc/passwd
>>filename:/etc/passwd,linenumber:1,columns:7,linecontent:root:x:0:0:root:/root:/bin/bash
>>filename:/etc/passwd,linenumber:2,columns:7,linecontent:daemon:x:1:1:daemon:/usr/sbin:/bin/sh


# 可以用printf代替print 进行格式化输出
awk  -F ':'  '{printf("filename:%10s,linenumber:%s,columns:%s,linecontent:%s\n",FILENAME,NR,NF,$0)}' /etc/passwd


6、变量和赋值

# 用count来统计用户人数
# 每输出一行，count就加1
# 最后打印出count
# 字符串用""
# 每个动作后加分号;
awk '{count++;print $0;} END{print "user count is ", count}' /etc/passwd

# count 初始化版本
awk 'BEGIN {count=0;print "[start]user count is ", count} {count=count+1;print $0;} END{print "[end]user count is ", count}' /etc/passwd


# 统计当前文件夹下所有文件的大小
ls -l |awk 'BEGIN {size=0;} {size=size+$5;} END {print "size is ", size/1024, "KB"}'

# 条件语句
if (expression) {
    statement;
    statement;
    ... ...
}

if (expression) {
    statement;
} else {
    statement2;
}

if (expression) {
    statement1;
} else if (expression1) {
    statement2;
} else {
    statement3;
}

# 过滤大于4k的文件
ls -l |awk 'BEGIN {size=0;print "[start]size is ", size} {if($5<4096){size=size+$5;}} END{print "[end]size is ", size/1024/1024,"M"}' 

# 当然可以用for while等，语句形式跟c语言一致
# 显示用户，前面加上序号
# 最后执行END操作
awk -F ':' 'BEGIN {count=0;} {name[count] = $1;count++;}; END{for (i = 0; i < NR; i++) print i, name[i]}' /etc/passwd
>>0 root
>>1 bin
>>2 daemon
>>3 adm
>>4 lp
>>5 syn
