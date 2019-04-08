# merge : 오라클에 조인 연산
# * 단점 : 한 번에 3개 이상의 데이터의 조인 불가, equi-join만 가능

merge(x, y, # 조인할 두 데이터 
      by = , # 조인컬럼(양쪽 컬럼이름 같을 경우)
      by.x = by, # (첫번째 데이터 조인컬럼, 조인컬럼 다수이면 벡터로 전달)
      by.y = by, # (두번째 데이터 조인컬럼)
      all = FALSE, # full outer join
      all.x = all, # left outer join
      all.y = all) # right outer join

data1 <- data.frame(a1=c(1,2,3,4),b1=c('aa','bb','cc','dd'))
data2 <- data.frame(a2=c(1,2,4,5),b2=c('aaa','bbb','ddd','eee'))

merge(data1, data2, by.x = 'a1', by.y = 'a2')
merge(data1, data2, by.x = 'a1', by.y = 'a2', all.x = T)
merge(data1, data2, by.x = 'a1', by.y = 'a2', all.y = T)
merge(data1, data2, by.x = 'a1', by.y = 'a2', all = T)

# emp를 사용하여 각 직원의 이름, SAL과 상위관리자 이름, SAL을 동시 출력
# (단, 상위관리자가 없는 경우도 함께 출력)
emp <- read.csv('emp.csv', stringsAsFactors = F)
merge(emp, emp, by.x = 'MGR', by.y = 'EMPNO', all.x = T)[, c('ENAME.x','SAL.x',
                                                             'ENAME.y','SAL.y')]
# which.min, which.max
emp[which.max(emp$SAL),]

# 그룹연산
# 1) tapply
tapply(vector, index, function)

# 2) aggregate
help(aggregate)

## S3 method for class 'data.frame'
aggregate(x,   -- 연산 대상, data frame 가능 
          by,  -- group by 컬럼, list로 전달, 여러 컬럼 전달 가능
          FUN)

# studnet data에서 학년별 키와 몸무게의 평균
aggregate(std[,c('HEIGHT','WEIGHT')],
          by = list(std$GRADE),
          mean)

# studnet data에서 학년별, 학과별 키와 몸무게의 평균
aggregate(std[,c('HEIGHT','WEIGHT')],
          by = list(std$GRADE, std$DEPTNO1),
          mean)

## S3 method for class 'formula'
aggregate(formula, -- 연산 대상 ~ group by 컬럼
          data,    -- 위를 포함한 전체 데이터 셋
          FUN)

# studnet data에서 학년별 키와 몸무게의 평균
aggregate(HEIGHT + WEIGHT ~ GRADE,   # fomula의 연산 대상의 +는 컬럼확장 X
          std,
          mean)

aggregate(cbind(HEIGHT,WEIGHT) ~ GRADE, # 연산 대상의 컬럼확장은 cbind
          std,
          mean)

# studnet data에서 학년별, 학과별 키와 몸무게의 평균
aggregate(cbind(HEIGHT,WEIGHT) ~ GRADE + DEPTNO1, 
          std,
          mean)

# student.csv와 exam_01.csv 파일을 사용하여 학생들의 
# 성별, 학년별 시험성적 평균
exam <- read.csv('exam_01.csv')
df_std <- merge(std,exam, by='STUDNO')[,c('JUMIN','GRADE','TOTAL')]
df_std$GENDER <- ifelse(substr(df_std$JUMIN,7,7) == '1','M','F')

aggregate(TOTAL ~ GENDER + GRADE,
          df_std,
          mean)

# stack, unstack : 데이터의 구조 변경(tidy data)
# stack(data)
# unstack(data,fomula) -- fomula : values ~ ind(여러컬럼으로 분리할 대상)
df_t <- data.frame('m'=c(90,89,84), 'f'=c(94,87,87))

df_s <- stack(df_t)
unstack(df_s)

# 월별 라떼 판매 수량을 월별 서로 다른 컬럼으로 정리(stack -> unstack)
df_melt <- read.csv('melt_ex.csv')
unstack(df_melt, latte ~ mon)
unstack(df_melt, mocha ~ mon)

# sqldf : R에서도 sql문법을 활용하여 데이터를 조작할 수 있음
install.packages('sqldf')
library(sqldf)
library(googleVis)

sqldf('select * from Fruits where Year = \'2008\' ')
sqldf("select * from Fruits where Year = '2008' ")

# plyr 패키지
# adply : apply와 비슷, 출력결과 데이터프레임
library(plyr)
Fruits
apply(Fruits[,4:6],2,sum)
adply(Fruits[,4:6],2,sum)

# ddply : 그룹연산 수행, 출력 결과 데이터프레임
ddply(data,       -- 전체 데이터 셋
      .(),        -- group by 컬럼 
      ddply-func, -- ddply 내부 함수(transform, mutate, subset..)
      fun)        -- 그룹함수(컬럼이름과 함께 전달)

ddply(Fruits, .(Fruit), transform, m1 = mean(Sales))
ddply(Fruits, .(Fruit), mutate, m1 = mean(Sales))

# ddply 내부함수
- transform : ddply의 연산 결과를 즉시 컬럼 이름 지정과 함께 출력 가능
- mutate : transform과 비슷하지만 순차적 연산처리를 할 경우 사용
- summarise : group 연산 결과를 group의 수에 맞게 요약 정보 제공
- subset : 그룹별 연산의 결과를 사용하여 추가적 조건에 만족하는 데이터 출력

# student를 사용하여 각 학년별 키와 몸무게의 평균
ddply(std, .(GRADE), transform, avg_height = mean(HEIGHT),
                                avg_weight = mean(WEIGHT))

ddply(std, .(GRADE), transform, avg_height = mean(HEIGHT),
                                avg_height2 = avg_height * 100)  # 불가

ddply(std, .(GRADE), mutate, avg_height = mean(HEIGHT),
                            avg_height2 = avg_height * 100)  # 가능

imsi <- ddply(std, .(GRADE), summarise, avg_height = mean(HEIGHT)) # 그룹연산 요약
std

merge(std, imsi, by = 'GRADE')  # 조인을 통해 원본데이터와 그룹연산 데이터 합침

# 예제
# 1. 학년별 최대 키
tapply(std$HEIGHT, std$GRADE, max)
aggregate( HEIGHT ~ GRADE, std, max)
data1 <- ddply(std, .(GRADE), summarise, max_height = max(HEIGHT))

# 2. 학년별 최대 키를 갖는 사람의 이름, 학년, 키
merge(std, data1,
      by.x = c('GRADE', 'HEIGHT'),
      by.y = c('GRADE', 'max_height'))[ , c('NAME','GRADE','HEIGHT')]

ddply(std, .(GRADE), transform, max_height = max(HEIGHT))
ddply(std, .(GRADE), subset, 
      HEIGHT == max(HEIGHT))[ , c('NAME','GRADE','HEIGHT')]

# 학년별 평균키보다 큰 학생의 정보 출력
ddply(std, .(GRADE), subset, 
      HEIGHT > mean(HEIGHT))[ , c('NAME','GRADE','HEIGHT')]



