# employment.csv 파일을 읽고
em <- read.csv('employment.csv', stringsAsFactors = F, na.strings = '-')
str(em)
# 컬럼명과 첫번째 행의 각 세부항목을 결합하여 새로운 컬럼 이름 설정
v1 <- substr(colnames(em),2,5)[-1]
em[1,-1]

strsplit(em[1,-1],' ')[[1]][1]  # split 함수 벡터 연산 불가

f_split <- function(x) {
  strsplit(x,' ')[[1]][1]
}

v2 <- sapply(em[1,-1],f_split)

colnames(em)[-1] <- str_c(v1,v2,sep='_')

em <- em[-1,]
head(em)

# 모든 컬럼(첫번째 제외) 숫자 변경
f_numeric <- function(x) {
  as.numeric(str_replace_all(x,',',''))
}

em[,-1] <- sapply(em[,-1], f_numeric)
str(em)
# 1) 각 년도별 월급여액 평균
data1 <- em[ ,str_detect(colnames(em),'월급여액')]
apply(data1, 2, mean)

# 2) 각 년도별 총근로일수 평균
data2 <- em[ ,str_detect(colnames(em),'총근로일수')]
apply(data2, 2, mean, na.rm = T)


# 데이터의 구조 변경 wide <-> long
# 1. stack과 unstack : 비교적 간단한 구조의 변경
# 2. reshape2::melt와 reshape2::dcast : 다양한 옵션 사용 가능, 
# 교차테이블 작성 시 편리
install.packages('reshape2')
library(reshape2)

m1 <- read.csv('melt_ex.csv')
d1 <- read.csv('dcast_ex1.csv')
d2 <- read.csv('dcast_ex2.csv')

stack(m1) # 이미 stack된 컬럼까지도 모두 stack처리. 컬럼 고정 불

# melt : stack 함수처럼 동일 관측치의 값이 각 컬럼으로 분리되어 
# 있는 경우 하나의 컬럼으로 쌓는 형식

melt(data,        -- 원본 데이터
     id,          -- 고정 컬럼
     measure.var) -- stack처리 할 컬럼(생략시 id컬럼 제외 모든 컬럼)

melt_d1 <- melt(m1, id=c('year','mon')) # year와 mon 컬럼 고정 나머지 stack
melt_d1[order(melt_d1$year, melt_d1$mon) , ] #stack된 데이터의 정렬

melt(m1, id=c('year','mon'),
         measure.vars = 'latte')

# dcast : unstack 함수처럼 이미 stack된 컬럼을 각 항목별로 분리하기 위해 사용
# 교차테이블 작성 가능
dcast(data,                          -- 원본데이터
      formula,                       -- 행고정 ~ unstack 처리 컬럼
      fun.aggregate = NULL,          -- 데이터 축약 시 사용 함수
      margins = NULL,                -- 부분합 출력시 TRUE
      value.var = guess_value(data)) -- value 컬럼 지정
                                     -- 생략가능, 생략 시 마지막 컬럼 지정

# d1 데이터를 사용하여 품목별 price와 qty 교차 테이블
dcast(d1, name ~ info)  

# d1 데이터를 사용하여 년도별 price와 qty 교차 테이블
dcast(d1, year ~ info) # 데이터 축약 발생, default로 데이터의 수 출력

# d1 데이터를 사용하여 년도별 price와 qty의 총 합을 나타내는 교차 테이블
dcast(d1, year ~ info, fun.aggregate = sum) 

# d2 데이터를 사용하여 년도별 품목별 교차 테이블 작성
dcast(d2, year ~ name)  # value 컬럼 생략 시 자동으로 마지막 컬럼 선택
dcast(d2, year ~ name, value.var = 'qty') # value 컬럼 지정

# 부분합
dcast(d2, year ~ name, margins = T, fun.aggregate = sum) 













