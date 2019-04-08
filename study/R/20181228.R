v1 <- ...

1. next���� ���� ��
for ( i in 1:10 ) {
  cmd1
  cmd2
  if ( i == 5 ) {   # i�� 5�̸� cmd3 ���� for�� ���� �۵�, cmd4 ���� �۵�
    next
  } 
  cmd3
}
cmd4

2. break ���� ���� ��
for ( i in 1:10 ) {
  cmd1
  cmd2
  if ( i == 5 ) {  
    break         # i�� 5�� �Ǵ� �������� cmd3�� �ƴ϶� 
  }               # �ݺ��� �� ��� ���ɾ� ����, cmd4 ���� ����
  cmd3
}
cmd4

3. exit ���� ���� ��
for ( i in 1:10 ) {
  cmd1
  cmd2
  if ( i == 5 ) {
    exit 0      # ��� ����, cmd4 ����
  } 
  cmd3
}
cmd4


# stringr ��Ű�� : ���ڿ� �Լ�
library(stringr)
1. str_detect : ���Һ� ���� �˻�(����Ŭ�� like�����ڿ� ���)
v1 <- c('aa','ba','ccb','Ab')
v1[str_detect(v1,'a')]   # ���� ������� 'a'�� �����ϴ�
v1[str_detect(v1,'^a')]  # 'a'�� �����ϴ�
v1[str_detect(v1,'a$')]  # 'a'�� ������
v1[str_detect(v1,'^[aA]')] # ��� ��� ���� a�� �����ϴ�
v1[str_detect(v1,'^[aAbB]')] # ��� ��� ���� a�Ǵ� b�� �����ϴ�
v1[str_detect(v1,'^[aA][bB]')] # ��� ������� a�� ����, �ι�°�� b

# [aA] : a or A (���ڿ� ǥ���Ŀ����� []�� �ϳ��� ���� ���� �ϼ�)

# emp���� �̸��� S�� �����ϴ� ������ ���� ���
emp[str_detect(emp$ENAME, '^[sS]'),]

v1[c(T,F,F)]
emp[ c(T,F,F,.....)  , c(T,F,F,.....) ]


2. str_locate
str_locate('abab','a')  # ù ��° 'a'�� ��ġ, ������ġ �� ��ġ ����
str_locate('aabab','a')  # ù ��° 'a'�� ��ġ, ������ġ �� ��ġ ����
str_locate('aabab','aa')  # ù ��° 'aa'�� ��ġ, ������ġ �� ��ġ �ٸ�
class(str_locate('abab','a'))

v3 <- c('a)','ab)a','b)','aba)bab')
str_locate(v3,'\\)')

v3 <- c('a','aba','b','ababab')
str_locate_all(v3,'a')[[2]][2,1]  # �ι�° ������ �ι�° a�� ��ġ

# 3. str_replace
v4 <- c('1,100','1,002,300','3,900')
v4 + 100  # v4�� ���ڿ��̶� ���� �Ұ�
v4 <- str_replace_all(v4,',','')  # ��� õ���� ���б�ȣ ����
as.numeric(v4) + 100  # �����ϴ��� ������ �����̹Ƿ� ���ڷ� �� ��ȯ �ʿ�

# student.csv ������ �а�
student <- read.csv("student.csv")
library(stringr)
# 1. TEL �÷��� ����Ͽ� ������ȣ ����
str_sub(student$TEL,
        1,
        str_locate(student$TEL,'\\)')[,1] - 1)

str_locate(student$TEL,'\\)')[,1] - 1   # ')'�� ��ġ - 1

str_split(student$TEL,'\\)')[[1]][1]

v1 <- c()
for (i in 1:length(student$TEL)) {
  v1 <- c(v1,str_split(student$TEL,'\\)')[[i]][1])
}
v1

# 2. ���л� ������ ����
student[str_sub(student$JUMIN,7,7) == "2", ]

# 3. ���� ��ȯ���� Ȱ���Ͽ� ���� �÷� �߰�("����","����")
student$���� <- ifelse(str_sub(student$JUMIN,7,7) == "2","����","����")

v2 <- c()
for (i in str_sub(student$JUMIN,7,7)) {
  if (i == "2") {
    v2 <- c(v2,"����")
  } else {
    v2 <- c(v2,"����")
  }
}
student$����2 <- v2