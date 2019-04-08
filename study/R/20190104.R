# 1. emp �����͸� ����Ͽ� �� �μ��� �ִ� �������� ���Ͽ���
emp <- read.csv("emp.csv", stringsAsFactors = F)
df1 <- as.data.frame(tapply(emp$SAL, emp$DEPTNO, max))
df1 <- cbind(row.names(df1), df1)
colnames(df1) <- c('DEPTNO','SAL')   

# 2. ���� �����͸� Ȱ���Ͽ� �μ��� �ִ밪�� ���� 
# ������ �̸�, �μ�, ����, �ִ뿬���� �Բ� ����Ͽ���.
emp[emp$SAL == 5000 & emp$DEPTNO == 10, c("ENAME","SAL","DEPTNO")]

f_max <- function(x) {
  emp[emp$SAL == x[2] & emp$DEPTNO == x[1], c("ENAME","SAL","DEPTNO")]
}

apply(df1,1,f_max)


# 3. data2 �����͸� �а� 
data2 <- read.csv('data2.csv', stringsAsFactors = F)
str(data2)

ff <- function(x) {
  as.numeric(str_replace_all(x,',',''))
}

data2[ ,c(3,4)] <- sapply(data2[ ,c(3,4)],ff)
str(data2)

# 1) ������ ���� �뼱�� �������� �� ���� ǥ��
#     line_1  line_2  line_3  line_4
#      XXXXX   XXXXX   XXXXX   XXXXX
tapply(data2$���� + data2$����, data2$�뼱��ȣ, sum)

# 2) ���� ������ �������� �� ���� ǥ��
# ���� ����
# XXXX XXXXX
tapply(data2$���� + data2$����, data2$�ð�, sum)

str_replace_all('506','[0-9][0-9]$','')
str_replace_all('1506','[0-9][0-9]$','')

data2$time <- as.numeric(str_replace_all(data2$�ð�,'[0-9][0-9]$',''))

v_r <- tapply(data2$���� + data2$����, data2$time >= 12 , sum)
names(v_r) <- c('����','����')
v_r

tapply(data2$���� + data2$����, 
       ifelse(data2$time >= 12,'����','����') , 
       sum)


# ���� : order, Doby::orderBy, sort
v1 <- c(1,10,2,5,3)
v2 <- c(1,10,2,NA,5,3)

# 1) order : ���ĵ� ���� ��ġ �� ����, ������ ���� ���ĵ� �� ��� ����
v1[order(v1)]
v2[order(v2)]
v2[order(v2, na.last = F)]  # NA�� ó������ ��ġ
v1[order(v1, decreasing = T)] # �������� ����

# 2) sort : ���ĵ� ���� ���� ���� ���� �ٷ� ����
sort(v1)
sort(v1, decreasing = T)

# ex) emp���� SAL�� ū ������� ������ ����
emp <- read.csv('emp.csv', stringsAsFactors = F)
order(emp$SAL, decreasing = T)
emp[order(emp$SAL, decreasing = T),]

sort(emp$SAL, decreasing = T)

library(doBy)
orderBy(formula,data)  # �����÷� ~ �����÷�, ���� data
orderBy( ~ SAL, emp)   # ���ķ����� �ݵ�� �÷����� ����
orderBy( ~ SAL, emp, decreasing = T) # �������� ���� �Ұ�

# ex) emp���� DEPTNO�� ����, DEPTNO�� ���� ���  SAL ������� ������ ����
emp[order(emp$DEPTNO, emp$SAL),]
emp[order(emp$DEPTNO, emp$SAL, decreasing = T),]
orderBy( ~ DEPTNO + SAL , emp) 

nrow(iris)

iris[sample(1:150,150),][1:100,]
iris[sample(1:150,100),]

# sample�� ����Ͽ� �����ϰ� 70% ������ ����
sample(1:nrow(iris),nrow(iris)*0.7)
train <- iris[sample(1:nrow(iris),nrow(iris)*0.7),]

# merge : ����Ŭ�� ���� ����
# * ���� : �� ���� 3�� �̻��� �������� ���� �Ұ�, equi-join�� ����

merge(x, y, # ������ �� ������ 
      by = , # �����÷�(���� �÷��̸� ���� ���)
      by.x = by, # (ù��° ������ �����÷�, �����÷� �ټ��̸� ���ͷ� ����)
      by.y = by, # (�ι�° ������ �����÷�)
      all = FALSE, # full outer join
      all.x = all, # left outer join
      all.y = all) # right outer join

# emp�� dept ���̺� ����
emp <- read.csv("emp.csv", stringsAsFactors = F)
dept <- read.csv("dept.csv", stringsAsFactors = F)

merge(emp, dept, by='DEPTNO')[ , c("ENAME","DEPTNO","DNAME")]
merge(emp, dept, by.x = 'DEPTNO', by.y = 'DEPTNO')

merge(student, professor, by.x = c('PROFNO',...), by.y = c('PROFNO',...),
      all.x=T)






