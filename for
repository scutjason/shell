                            for
1、数字循环
# 注意用双()，不要留空格，*号前面加\是为了怕误以为是匹配字符
# 跟c语言差不多
for((i=1;i<=10;i++)); 
do   
    echo $(expr $i \* 3 + 1);  
done
>> 4 
>> 7
>> ...

2、用seq序列
# 注意要加$()包起来
for i in $(seq 1 10)  
do   
    echo $(expr $i \* 3 + 1);  
done 
>> 4 
>> 7
>> ...

3、直接用{}
# {a..b}表示 从a开始默认间隔为1，一直到b
for i in {1..10}
do
    echo $(expr $i \* 3 + 1);
done
>> 4 
>> 7
>> ...

4、用awk
# BEGIN后面是表达式
# awk中的for循环跟c语言一直
awk 'BEGIN{for(i=1; i<=10; i++) print i}' 

5、字符循环
# 注意这里的`ls`输出的是ls命令
for i in `ls`;  
do   
    echo $i is file name\! ;  
done 
>> test_shell.sh is file name!
>> sbt is file name!

6、字符串循环
# in默认按空格遍历
list="rootfs usr data data2"  
for i in $list;  
do  
  echo $i is appoint ;  
done
>>rootfs is appoint
>>usr is appoint
>>data is appoint
>>data2 is appoint

7、按路径遍历
for file in /proc/*;  
do  
    echo $file is file path \! ;  
done  
>> /proc/vmstat is file path !
>> /proc/zoneinfo is file path !

