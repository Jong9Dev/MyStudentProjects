v1 <- c('a','b','c')
v2 <- c(1,2,3)

str_c(v1,v2, sep = '_')

# 함수에 여러개의 인자 전달이 필요한 경우
# 1) apply(array, margin, ...)
d1 <- data.frame(v1,v2)

f1 <- function(x) {
  str_c(x[1], x[2], sep = '_')
}

apply(d1, 1, f1)

# 2) mapply(function, ...)
f2 <- function(x,y) {
  str_c(x, y, sep = '_')
}

mapply(f1, v1, v2) # 불가, f1은 하나의 인자를 받도록 생성
mapply(f2, v1, v2) # 가능, f2는 두 개의 인자를 받도록 생성

# 다수의 인자를 갖는 함수 생성 및 적용 예제
# f_substr 함수를 오라클 함수와 동일한 기능을 갖도록 만들고
# 다음에 적용하여 첫번째서부터 3개의 문자 추출
data1 <- c('ab/c','bcd/e','abcd/r' )
substr('abcde',2,3)
substr('abcde',2,2+3-1)

f_substr <- function(data,start,n) {
  substr(data,start, start + n - 1)
}

f_substr(data1,1,3) # f_substr 자체가 벡터연산이 되기 때문에 연산 가능

mapply(f_substr,data1,1,3) # 함수가 벡터연산이 되지 않는다면 mapply 통해 적용
mapply(f_substr,data1,c(1,1,1),c(2,3,4))

d1 <- data.frame(data1,start=c(1,1,1),n=c(2,3,4))

apply(d1,1,f_substr)
str(d1)

f_substr <- function(data) {
  substr(data[1],data[2], as.numeric(data[2]) + as.numeric(data[3]) - 1)
}

# f_substr2('abc@naver.com','@')

# apply 계열 함수 : 함수의 반복적 적용을 위해 필요
1) apply  
- 2차원구조 적용가능, 벡터에 적용 불가
- 행별, 열별 연산을 위해 만들어짐
- 그룹함수의 적용과 잘 사용됌
- 행별, 열별로 묶어서 "벡터"로 함수에 전달하므로 함수는 
  하나의 인자를 갖아야 함

m1 <- matrix(1:9, ncol = 3)
apply(m1,1,sum)
apply(m1,2,sum)

2) lapply 
- "원소별" 적용을 위해 만들어진 함수
- 리스트와 데이터프레임(key를 갖는 구조)은 key별로 연산되기도 함
- 출력 결과 리스트이므로 아래 sapply를 주로 사용
f1 <- function(x) {
  strsplit(x,'/')[[1]][1]
}
v1 <- c('a/b', 'aa/bb','aaa/bbb')
f1(v1,'/')  # 원소별 적용 불가(strsplit 자체가 벡터연산 불가)
lapply(v1, f1)

3) sapply
- 함수에 "원소별" 적용이 필요한 경우 사용
- 벡터연산이 되더라도 데이터프레임과 같은 2차원 구조에 적용할 수 없을 경우
  반드시 필요
- 출력결과는 벡터 또는 2차원 구조인 행렬
- 데이터프레임에 적용 가능(출력은 행렬)
sapply(v1, f1)

4) tapply 
- 그룹별 분할 함수 적용이 필요한 경우 사용(그룹연산)
- 분할 - 적용 - 결합의 순서대로 연산
- 분할된 데이터는 벡터형태로 전달 
- 출력 결과 벡터
- aggragate, ddply를 통해서도 그룹연산 가능(출력 결과 데이터프레임)

5) mapply
- 함수에 다수의 인자를 반복 적용하기 위해 사용
- apply로도 다수의 인자를 적용할 수 있지만 mapply가 주로 사용
- mapply의 인자가 스칼라일 경우 각 함수에 동일 값이 적용됌
ex) mapply(substr, c('abc','bcde'), 1, 2)
   => 적용대상('abc','bcde')에 모두 1과 2라는 인자 적용
mapply(substr, c('abc','bcde'), 
               c(1,2),
               c(2,3))  => 서로 다른 인자 전달 가능

# 기타 데이터 조작 함수 정리
1. which.max, which.min
- 벡터의 최대값과 최소값을 갖는 위치 값 리턴, reindex 필요

2. order, doBy::orderBy, sort

3. rank 
- 벡터의 각 값의 순위 출력
rank(x, na.last = TRUE,
     ties.method = c("average", -- 동률순위를 각 순위의 평균으로 통일
                     "first",   -- 동률일 경우 처음 오는 순서대로 1순위
                     "last",    -- 마지막 데이터에 1순위
                     "random",  -- 순서상관없이 랜덤
                     "max",     -- 동률순위중 가장 높은값 출력
                     "min"))    -- 동률순위중 가장 낮은값 출력(보편적)

4. rowSums, rowMeans, colSums, colMeans
- apply에서 각 행별, 컬럼별 연산 가능
- 합과 평균만 가능

5. zoo::na.locf 
- 파이썬에서 fillna, shift 함수처럼 NA를 갖는 경우 이전 값 가져올 수 있음
- 데이터프레임 적용 시 각 컬럼별 NA값을 이전 행 값으로 치환

6. na.omit, tidyr::drop_na
- NA를 포함하는 행 삭제
- 데이터프레임 적용 가능


disease.txt 파일을 읽고, 
d1 <- read.table('disease.txt', header = T, encoding = 'utf-8')
read.csv('disease.txt', sep=",")

1) 대장균이 가장 많이 발병한 달을 출력
d1[which.max(d1$대장균), 1]

2) 데이터를 A형간염이 많은 순으로 정렬
library(doBy)
orderBy( ~ A형간염 , d1, decreasing=T)
d1[order(d1$A형간염, decreasing=T), ]

3) 콜레라 기준으로 순위 출력(rank함수)
d1$rank <- rank(d1$콜레라, ties.method='min')
orderBy(~ 콜레라,d1)

4) 각 질병 별 발병횟수의 총 합을 출력
colSums(d1[,2:6], na.rm = T)
apply(d1[,2:6], 2, sum, na.rm = T)

5) na 값을 이전 행 값으로 치환
install.packages('zoo')
library(zoo)
na.locf(d1)

f_fillna <- function(x) {
  v1 <- c()
  for ( i in 1:length(x) ) {
    if (is.na(x[i])) {
      v1 <- c(v1,x[i-1])
    } else {
      v1 <- c(v1,x[i])
    }
  }
  return(v1)
}

apply(d1[,-1],2,f_fillna)

6) na 값이 존재하는 행 삭제
na.omit(d1)
help("drop_na")
install.packages('tidyr')
library(tidyr)
drop_na(d1)

is.na(d1) # is.na 함수는 벡터연산, 데이터프레임 확장 가능
rowSums(is.na(d1)) # boolean값의 산술연산은 T=1, F=0으로 계산
d1[rowSums(is.na(d1)) == 0,]


[ 시험 힌트 ]
1. 데이터프레임/리스트 색인
2. ifelse 
3. 치환
4. 문자열함수(str_detect, str_c, paste, str_replace, strsplit, substr)
5. 데이터프레임 구조변경
6. 사용자정의함수(벡터생성)
7. 형변환함수

  

