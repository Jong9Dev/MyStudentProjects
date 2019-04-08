var1 <- 0          # ������ ��Į��  
var1 <- c(1,2)     # ������ ����
var2 <- c("a","b") # ������ ����
var3 <- Sys.Date() # ��¥�� ��Į��

class(var1)
class(var2)
class(var3)

1 + "10" #(X)
1 + 10   #(O)
1 + as.numeric("10") #(O)

help(seq)

seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
    length.out = NULL, along.with = NULL, ...)

var5 <- seq(1,10,2)
seq(from = 1, to = 10, by = 2)
seq(to = 10, from = 1, by = 2)

seq('2018/12/01', '2018/12/31',1) # �����߻�(������ sequence ��� �Ұ�)

seq(as.Date('2018/12/01','%Y/%m/%d'),
    as.Date('2018/12/31','%Y/%m/%d'),
    1) # �������� ��¥�� ���

as.Date('2018/12/01','%Y/%m/%d') # ��¥����
as.Date('2018/12/01')

# to_date('2018/12/01','YYYY/MM/DD') => as.Date('2018/12/01','%Y/%m/%d')

var11 <- NULL
var12 <- c(1,NULL)
var11
var12

is.na(var11)   # logical(0), NULL�� ��� NAüũ ���� �Ұ�
is.na(var12)   # false, var12 ������ ��ü NA���� üũ
is.null(var11) # true, var11������ ���� �ִ��� ������ üũ
is.null(var12) # false

# ������������ ����
# and ���� : &, &&
# or  ���� : |, ||

c(TRUE,FALSE) & c(TRUE,TRUE) # ���Һ� and �������� ����
c(TRUE,FALSE) | c(TRUE,TRUE) # ���Һ� or �������� ����
c(TRUE,FALSE) && c(FALSE,TRUE) # �� �ϳ��� ������(�� ��)�� and �������� ����
c(TRUE,FALSE) || c(FALSE,TRUE) # �� �ϳ��� ������(�� ��)�� or �������� ����


a <- 3
b <- -3
(a > 0) & (b > 0)  # FALSE
(a > 0) | (b > 0)  # TRUE
(a > 0) && (b > 0) # FALSE
(a > 0) || (b > 0) # TRUE

# => �ϳ����� ���� ������ �����ڸ� �� �� ���� �� �� ���� ��� ����


