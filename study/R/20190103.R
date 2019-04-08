v1 <- scan("test1.txt") # 외부 텍스트 파일 불러오기 (벡터로 저장)
v2 <- scan() # 사용자가 입력한 숫자 값을 벡터로 저장
v3 <- scan(what = "") # 사용자가 입력한 문자 값을 벡터로 저장

ans <- readline("값을 입력하세요 | Y or N :")
if (ans == "Y") {
  
} else {
  
}

scan("test1.txt") # 라인 상관 없이 공백으로 구분된 단어가 각 쉘로 처리
readLines("test1.txt") # 라인이 하나의 쉘로 처리

emp

# 사용자 정의 함수 생성(f_bonus)
# emp에서 SAL이 3000이상이면 SAL의 10%를, 미만이면 8%를 출력
f_bonus <- function(x) {
  if (x>=3000) {
    return(x*1.1)
  } else {
    return(x*1.08)
  }
}

f_bonus(5000)
f_bonus(emp$SAL)

sapply(emp$SAL,f_bonus) # 벡터에 함수를 반복 적용, 결과가 벡터
lapply(emp$SAL,f_bonus) # 벡터에 함수를 반복 적용, 결과가 리스트

m1 <- matrix(1:9,ncol = 3)

# apply(데이터셋,적용방향,적용함수) , 방향은 1:행별, 2:열별, c(1,2):원소별
apply(m1,1,sum)      #행별(서로 같은 행끼리) sum 연산
apply(m1,2,sum)      #열별(서로 같은 행끼리) sum 연산
apply(m1,c(1,2),sum)

f1 <- function(x) {
  return(x+3)
}

apply(m1,1,f1)  # f1은 일대일 치환 함수지만 r에선 apply로 적용가능(파이썬불가)
sapply(m1,f1)   # m1의 각 원소별 함수의 적용 가능, 벡터 출력
lapply(m1, f1)  # m1의 각 원소별 함수의 적용 가능, 리스트 출력

m2 <- matrix(c('a1','a2','a3','a4'), nrow = 2)

# 두번째 글자만 추출하는 사용자 정의함수 생성 및 적용
# 1) 생성
f2 <- function(x) {
  return(substr(x,2,2))
}

2) 적용
f2(m2)
apply(m2,1,f2) 

apply(iris[,-5],2,mean)

# 전염병발병현황 파일을 읽고
data1 <- read.csv("전염병발병현황.csv", stringsAsFactors = F)
str(data1)

# 1) 월별 발병수의 총합
apply(data1[,-1],1,sum)

# 2) 전염병별 발병수의 총합
apply(data1[,-1],2,sum)

# apply 계열 함수들의 함수의 추가인자 전달 방식
m1[2,2] <- NA
apply(m1, 1, sum)  # NA가 포함된 행의 결과는 NA로 리턴
rowSums(m1, na.rm = T)

help("apply")
apply(X, MARGIN, FUN, ...)   # ...	optional arguments to FUN.
apply(m1, 1, sum, na.rm = T) # na.rm = T을 sum 함수에 전달

# 사용자 정의함수 생성
# 입력한 문자열에서 입력한 개수만큼 처음부터 추출

substr(,,)
f("aabcx",3) = aab

f3 <- function(x,y) {
  substr(x,1,y)
}

f3("abcde",3)
f3(emp$ENAME,3)
apply(emp$ENAME,c(1,2),f3,3)
sapply(emp$ENAME,f3,2)

# tapply : 그룹별 연산
tapply(vector, index, function)
tapply(c(1,2,3,4),c(1,1,2,2),sum)

tapply(emp$SAL,emp$DEPTNO,mean,na.rm = T)

emp

rnorm(10,0,1)


mapply(function, ...)
mapply(rnorm,
       10,
       0,
       1)

mapply(rnorm,
       c(10,20),
       c(0,10),
       c(1,10))

# apply 관련 연습문제(fruits.csv 파일 이용)
fruits <- read.csv("fruits.csv", stringsAsFactors = F)

# 1. qty가 10 이상일때의 수량의 합과 미만일때의 수량의 합을 각각 계산
tapply(vector, index, function) # 첫 번째 인자는 반드시 벡터(데이터프레임 불가)
tapply(fruits$qty, fruits$qty >= 10, sum)
tapply(iris[,-5],iris$Species,mean) # 동시에 여러 컬럼 그룹연산 불가

# 2. 과일 이름별 price의 평균출력
tapply(fruits$price, fruits$name,mean)

# 3. 위에서 만든 f3 함수(전달된 인자의 수만큼 문자열 추출)를 수정,사용하여
# year컬럼에서 년도를 두자리 표현식으로 변경
f3 <- function(x,y,z) {
  substr(x,y,z)
}

substr(fruits$year,3,4)
f3(fruits$year,3,4)

sapply(fruits$year,substr,3,4)
mapply(substr,fruits$year,3,4)


