v1 <- c('ab','aaa','ba','ca','aba')
str_detect(v1,'ab')
v1[str_detect(v1,'ab')]

grep('ab',v1)
v1[grep('ab',v1)]

grep('ab',v1, value = T)  # value = T는 패턴에 해당되는 값 직접 추출

student

# v1에서 ab 또는 ba를 포함하는 값 출력
pattern <- c('ab','ba')
grep(pattern, v1)   # pattern은 2개 이상의 값을 가질 수 없다
grep('ab|ba', v1)   # | 연산자로 하나의 값으로 묶어서 전달(or 패턴 가능)

# paste : 문자열 결합 함수, str_c와 유사
paste('a','b','c')  # paste함수에 나열된 각 인자들을 하나로 결합
                    # 결합시 구분기호는 공백(default)
paste('a','b','c',sep='|') # 분리되어진 각 인자의 구분기호 지정
paste('a','b','c',collapse = '|') # 인자의 구분기호로는 전달불가

vv1 <- c('a','b','c')
paste(vv1,sep='|') # 벡터 내 원소의 구분기호로는 전달불가
paste(vv1,collapse = '|') # 벡터의 원소의 구분기호 지정

paste('a','b','c') 

help(sum)
sum(..., na.rm = FALSE)
sum(1,2,3)
sum(c(1,2,3))
help(mean)
mean(x, ...)
mean(1,2,3)
mean(c(1,2,3))

# abs와 동일한 사용자 정의함수를 f_abs이름으로 생성
f_abs <- function(x) {
  if (x>0) {
    return(x)
  } else {
    return(-1 * x)
  } 
}

# sign와 동일한 사용자 정의함수를 f_sign 이름으로 생성
f_sign <- function(x) {
  if (x>0) {
    return(1)
  } else if (x==0) {
    return(0)
  } else {
    return(-1)
  }
}

f_sign(0)

# 문제1. 사용자에게 정수 n 을 입력 받은 후 1 부터 n 까지의 합을 출력하기
sol1)
f(1) = 1
f(2) = 1 + 2               | f(1) + 2
f(3) = 1 + 2 + 3           | f(2) + 3
....
f(n) = 1 + 2 + 3 + ... + n | f(n-1) + n

f2 <- function(x) {
  if(x==1) {
    return(1)
  } else {
    return(f2(x-1) + x)
  }
}

f2(100)
f2(10) = f2(9) + 10
       = f2(8) + 9 + 10
       = f1(1) + 2 + 
sol2)
i sum 
1  1
2  1+2         | sum + 2
3  1+2+3       | sum + 3
4  1+2+3+4     | sum + 4
.....
n  1+2+3+4+..n | sum + n

f1 <- function(x) {
  sum <- 0
  for (i in 1:x) {
    sum <- sum + i
  }
  return(sum)
}

f1(100)

# 문제2. 팩토리얼 계산하기
factorial(10)
fac1 <- function(x) {
  sum <- 1
  for (i in 1:x) {
    sum <- sum * i
  }
  return(sum)
}

fac1(10)

fac2 <- function(x) {
  if(x==1) {
    return(1)
  } else {
    return(fac2(x-1) * x)
  }
}

fac2(10)

# 함수 인자의 기본값 설정
f3 <- function(x,y=3) {
  return(x + y)
}

f3(1)  #1 + 3(y=3)
f3(1,1)

# if 연습문제 5. 사용자가 대문자 'Y’나 소문자‘y’를 입력하면 화면에‘Yes’를
# 출력하고 그 외 다른 글자를 입력하면‘Not Yes’를 출력하는 
# 사용자 정의 함수를 만드세요.(함수명과 변수명은 자유롭게~)

f4 <- function(x) {
  if (x=='Y'| x=='y') {
    return('Yes')
  } else {
    return('Not Yes')
  }
}

f4 <- function(x) {
  if (x %in% c('Y','y')) {
    return('Yes')
  } else {
    return('Not Yes')
  }
}

f4('y')

#read.csv : 외부 csv 파일 불러오기
help(read.csv)
read.table(file, header = FALSE, sep = "", quote = "\"'",
           dec = ".", numerals = c("allow.loss", "warn.loss", "no.loss"),
           row.names, col.names, as.is = !stringsAsFactors,
           na.strings = "NA", colClasses = NA, nrows = -1,
           skip = 0, check.names = TRUE, fill = !blank.lines.skip,
           strip.white = FALSE, blank.lines.skip = TRUE,
           comment.char = "#",
           allowEscapes = FALSE, flush = FALSE,
           stringsAsFactors = default.stringsAsFactors(),
           fileEncoding = "", encoding = "unknown", text, skipNul = FALSE)

# sep : 각 컬럼의 구분기호
read.csv("file1.txt", sep = ",")
read.table("file1.txt", sep = ",")

# header : 첫 번째 행 컬럼화 여부
read.csv("file1.txt", sep = ",") # header = TRUE가 default
read.table("file1.txt", sep = ",", header = TRUE) # FALSE가 default

# na.strings = "NA" : NA 처리를 하고자 하는 문자열 지정
t1 <- read.table("file2.txt", sep = ",", header = TRUE)
str(t1) # '-' 때문에 D 컬럼 문자화

t2 <- read.table("file2.txt", sep = ",", header = TRUE,
                 na.strings = c("-","?"))
str(t2)
t2

# nrows : 일부 데이터의 로딩 시
read.csv("emp.csv", nrows = 3)

# skip = 0 : 일부 데이터의 로딩 제외 시 
read.csv("file3.txt")  #
read.csv("file3.txt", skip = 1) # 첫번째 행 제외

read.table("file4.txt") # read.table은 주석처리된 행은 로딩 제외

# stringsAsFactors : 문자열 컬럼을 팩터화 할 지 여부
emp <- read.csv("emp.csv", stringsAsFactors = F)
str(emp)

# encoding : 파일 인코딩 옵션(한글일 경우 cp949, R은 기본)
read.csv("student.csv", stringsAsFactors = F, encoding = 'cp949')

# read.csv와 read.table로 txt 파일 조회 시 EOF가 명시되어 있지 않은 
# 데이터는 로딩 시 다음의 경고 발생(무시)
Warning message:
  In read.table("file3.txt") :
  'file3.txt'에서 readTableHeader에 의하여 발견된 완성되지 않은 마지막 라인입니다
1) 마지막 라인에 빈칸(마지막 라인임을 명시) 넣기
2) read.delim 함수 사용
