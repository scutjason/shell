1、每一行开头或者末尾添加字符
awk '{print $0")"}' table_dim.txt >table_dim1.txt


2、替换table.txt第一个逗号为,"
	sed 's/,/,"/;' table.txt


3、替换table.txt第二个逗号为 ","     2表示第2次出现
	cat table.txt |sed 's/,/",/2' >table_dim2
	

4、获取引用符号 \1 表示引用括号内的内容（）
	-r表示后面的''里面是正则表达式
	sed -r 's/(output_type: ).*/\1"gp"/g' test_epn.sql


							sed
创建一个临时的行缓冲区，读入要处理的文本文件，在缓冲区中编辑处理之后，输出到屏幕，删掉缓冲区，再读入下一行
缓冲区只是副本，并不会改变源文件

1、打印p
# -n 取消默认输出
# '3p' 表示只打印第3行， 
# p是打印选项，如果不加3, 则表示全部打印
sed -n '3p' /etc/passwd
# 指定打印范围
sed -n '2,5p' /etc/passwd

# 搜索root字符串，并打印
# 格式就是 / /
sed -n '/root/p' /etc/passwd

2、删除d
# $ 表示最后一行
# 这里不加 -n , 将其他的打出来即可
sed '$d' /etc/passwd

# 也可以用具体某个具体字符串
sed '/root/d' /etc/passwd

3、替换s
# s加在/前面

# 匹配规则跟grep一样
# /^my/ 匹配所有以my开头的行
# /my$/ 匹配所有以my结尾的行
# /m..y/ 匹配包含字母m，后跟两个任意字符，再跟字母y的行
# /my*/ 匹配包含字母m,后跟零个或多个y字母的行
# /[Mm]y/ 匹配包含My或my的行
# /[^Mm]y/ 匹配包含y，但y之前的那个字符不是M或m的行
# s/my/**&**/  符号&代表查找串。my将被替换为**my**
# /\<my/ 匹配包含以my开头的单词的行
# /my\>/ 匹配包含以my结尾的单词的行
# /9\{5\}/匹配包含连续5个9的行
# /9\{5,\}/ 匹配包含至少连续5个9的行
# /9\{5,7\}/ 匹配包含连续5到7个9的行

# /g表示行内都匹配替换
# 将my开头的行都替换成you并打印
sed 's/^my/you/g' /etc/passwd

# 指定行数替换，并打印
# 要在g后面加p
sed '1,20s/my$/you/gp' /etc/passwd

# &
# 将root替换成rooter
sed  's/root/&er/' /etc/passwd

# ,表示范围
# 打印从第五行到包含def行之间的行
sed  -n '5/,/def/p' file

# () 组
# 组用\1 \2来引用前面的第一个(),第二个()
# 删除每行第二个字符
# (.*) 第三个字符开始任意长
# \1\3 取前面第一个括号和第三个括号内容
sed -nr 's/(.)(.)(.*)/\1\3/p' /etc/passwd  
