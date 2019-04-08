a1 <- array(1:20, c(2,5,2))

a2 <- array(1:20)
dim(a2) <- c(2,5,2)

a1[1,,1]    # �� ���� ���ΰ����� ���� ����
a1[,,1][1,] # �� ���� ���ΰ����� ���� ����(���� ��� ����)


# data frame ����
no <- c(1,2,3,4)
name <- c('apple', 'banana','peach','berry')
price <- c(500,200,200,50)
qty <- c(5,2,7,9)

df1 <- data.frame(no = no, name = name, price = price, qty = qty)

str(df1) # name �÷� factor ����
#data.frame���� ������������ ���鶧 ���ڿ� �÷��� �ڵ����� factor������ ����

df1
rbind(df1,c(5,'mango',100,10)) #������ �� �߰� ��, factor�� level�� �������
                               #���� ���� NAó��
# mango data ������ ����
# 1. data frame ������ ���ڿ� �÷��� factor�� �������� X
df2 <- data.frame(no = no, name = name, price = price, qty = qty,
                  stringsAsFactors = F)
str(df2)
df2 <- rbind(df2,c(5,'mango',100,10))

# 2. �̹� ������ data frame�� factor�� �÷��� �Ϲ� ���ڿ� �÷����� ����
df1$name <- as.character(df1$name)
str(df1)
df1 <- rbind(df1,c(5,'mango',100,10))

# �̹� ������ data frame�� ���ڿ� �÷��� factor������ ����
df1$name <- factor(df1$name)
str(df1)
df1

# banana�� BANANA�� ����
df1[2,2] <- 'BANANA'                # NA�� ���� ��
df1$name <- as.character(df1$name)  # �Ϲ� ���ڿ� �÷����� ���� ��
df1[2,2] <- 'BANANA'                # �ٽ� ����

# �÷� �߰�
df1$area <- c('a','b','c','a','b')  # �÷� �߰��� ���ڿ� �÷� factor�� ����X
area2 <- c('a','b','c','a','b')
df1 <- cbind(df1,area2) # cbind�� ���ڿ� �÷� ���� �� factor�� ����
str(df1)

# ������ ��� : ���� �������� ���� �������� �����Ͱ� ����Ǽ� ��µǴ� ����
# (3���� -> 2���� �Ǵ� 1����, 2���� -> 1����)
df1$name
df1[,'name',drop=F]

# %in% ������
# �̸��� apple�� peach�� �� ����
# where name in ('apple','peach')
c('apple','peach') %in% df1$name # apple�� peach�� name�÷����� ���� ���� Ȯ��
df1$name %in% c('apple','peach') # name�� �� ���� 
                                 # c('apple','peach')�� �ִ��� ���� Ȯ��

colnames(df1)
names(df1)

head(df1,2)
df1[1:2,]

m1 <- cbind(no,name,price,qty)
as.data.frame(m1)

# �ܺ� csv���� �ҷ�����
getwd()
emp <- read.csv('emp.csv')
str(emp)
# 1. empno�� 7900�� ����� �̸�, sal ���
emp[emp$EMPNO == 7900, c('ENAME','SAL')]

# 2. 1���� �Ի��� ����� �̸�, �Ի���, ���� ���
as.character(as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M'),
             '%m')

emp[as.character(as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M'),'%m') == '01',
    c('ENAME','HIREDATE','SAL')]

# 3. SMITH�� SCOTT�� ���� ���
emp[emp$ENAME == 'SMITH' | emp$ENAME == 'SCOTT', 'SAL']
emp[emp$ENAME %in% c('SMITH','SCOTT'),'SAL']

# 4. ������ �������� ������ ��� �� R_PAY �÷����� �߰�
#    (������ = ���� SAL * trunc(�ټӳ��/12))
var1 <- Sys.Date() - as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M') # �ѱٹ��ϼ�
wyear <- trunc(var1/365)
emp$R_PAY <- as.numeric(emp$SAL * trunc( wyear /12 ))
class(var1)

# if��(���ǹ�, ���� ���� �Ұ�)
# if���� ������ ���Һ� ���� ġȯ�� �Ұ� => for�� ���, ifelse �Լ� ���

vec1 <- c(10,20,30)

if ( vec1 == 10 ) {
  print("�λ��")
} else {
  print("�ѹ���")
}      # ������� �λ���� ���� : �� ù ����� 10�� ���ؼ��� ���� ġȯ ����

# ifelse (���ǹ�, ���� ���� ����)
# ������ ���Һ� ���� �˻� ����, ���Ǻ� ���ɾ��� ������ �Ұ�(only ���)
ifelse(vec1 == 10,'�λ��','�ѹ���')
             # in oracle : decode(vec1,10,'�λ��','�ѹ���')

ifelse(vec1 == 10,'�λ��',
                  ifelse(vec1 == 20, '�繫��','�ѹ���'))

# emp data frame���� deptno�� ������� �μ����� ���� dname �÷� �߰�
# (10 : �λ��, 20 : �繫��, 30: �ѹ���)

emp$dname <- ifelse(emp$DEPTNO == 10,
                    '�λ��',
                    ifelse(emp$DEPTNO == 20,
                           '�繫��',
                           '�ѹ���'))

# if���� else if ����
if ( vec1 == 10 ) {
  print("�λ��")
} else if ( vec1 == 20 ) {
  print("�繫��")
} else {
  print("�ѹ���")
}

# deptno �� 10�̸鼭 sal�� 4000�̻��� ����� "�ӿ��ĺ�"�� ���
# 1) if��
if ((emp$DEPTNO == 10) & (emp$SAL >= 4000 )) {
  print("�ӿ��ĺ�")
} else {
  print("�ӿ��ĺ��ƴ�")
}

# &  : �������� �������� ����
# && : �� �ϳ��� �������� ����
c(T,F) & c(F,F)
c(T,F) && c(F,F)

# 2) ifelse��
ifelse(emp$DEPTNO == 10 & emp$SAL >= 4000 ,'�ӿ��ĺ�','�ӿ��ĺ��ƴ�')


# for��(�ݺ���, �ݺ�Ƚ�� ������ ����)
for (i in c('a','b','c')) {
  print(i)
}

for (i in c('a','b','c')) {
  print(10)
}

emp$SAL * 0.1

for (i in emp$SAL) {
  print(i * 0.1)
}


for (i in vec1) {
  if ( i == 10 ) {
    print("�λ��")
  } else {
    print("�ѹ���")
  }
}

# emp���� sal�� 2000�̻��� ���� ���� �λ���� 10%,
# 2000�̸��� ���� 15%�� ���(for�� �� print�δ� �÷� ���� �Ұ�)

emp$NEW_SAL <- for (i in emp$SAL) {
  if (i >= 2000) {
    print(i * 1.1)
  } else {
    print(i * 1.15)
  }
}