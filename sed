1、每一行开头或者末尾添加字符
awk '{print $0")"}' table_dim.txt >table_dim1.txt


2、替换table.txt第一个逗号为,"
	sed 's/,/,"/;' table.txt


3、替换table.txt第二个逗号为 ","     2表示第2次出现
	cat table.txt |sed 's/,/",/2' >table_dim2
	

4、获取引用符号 \1 表示引用括号内的内容（）
	sed -r 's/(output_type: ).*/\1"gp"/g' test_epn.sql
