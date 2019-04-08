var1 <- 0          # 숫자형 스칼라  
var1 <- c(1,2)     # 숫자형 벡터
var2 <- c("a","b") # 문자형 벡터
var3 <- Sys.Date() # 날짜형 스칼라

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

seq('2018/12/01', '2018/12/31',1) # 에러발생(문자의 sequence 출력 불가)

seq(as.Date('2018/12/01','%Y/%m/%d'),
    as.Date('2018/12/31','%Y/%m/%d'),
    1) # 연속적인 날짜의 출력

as.Date('2018/12/01','%Y/%m/%d') # 날짜형식
as.Date('2018/12/01')

# to_date('2018/12/01','YYYY/MM/DD') => as.Date('2018/12/01','%Y/%m/%d')

var11 <- NULL
var12 <- c(1,NULL)
var11
var12

is.na(var11)   # logical(0), NULL인 경우 NA체크 여부 불가
is.na(var12)   # false, var12 변수가 전체 NA인지 체크
is.null(var11) # true, var11변수에 값이 있는지 없는지 체크
is.null(var12) # false

# 논리연산자의 사용법
# and 연산 : &, &&
# or  연산 : |, ||

c(TRUE,FALSE) & c(TRUE,TRUE) # 원소별 and 논리연산 수행
c(TRUE,FALSE) | c(TRUE,TRUE) # 원소별 or 논리연산 수행
c(TRUE,FALSE) && c(FALSE,TRUE) # 단 하나의 논리값(맨 앞)의 and 논리연산 수행
c(TRUE,FALSE) || c(FALSE,TRUE) # 단 하나의 논리값(맨 앞)의 or 논리연산 수행


a <- 3
b <- -3
(a > 0) & (b > 0)  # FALSE
(a > 0) | (b > 0)  # TRUE
(a > 0) && (b > 0) # FALSE
(a > 0) || (b > 0) # TRUE

# => 하나씩의 논리 연산은 연산자를 한 번 쓰나 두 번 쓰나 모두 가능



