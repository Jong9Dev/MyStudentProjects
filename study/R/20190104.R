# 1. emp 데이터를 사용하여 각 부서별 최대 연봉값을 구하여라
emp <- read.csv("emp.csv", stringsAsFactors = F)
df1 <- as.data.frame(tapply(emp$SAL, emp$DEPTNO, max))
df1 <- cbind(row.names(df1), df1)
colnames(df1) <- c('DEPTNO','SAL')   

# 2. 위의 데이터를 활용하여 부서별 최대값을 갖는 
# 직원의 이름, 부서, 연봉, 최대연봉을 함께 출력하여라.
emp[emp$SAL == 5000 & emp$DEPTNO == 10, c("ENAME","SAL","DEPTNO")]

f_max <- function(x) {
  emp[emp$SAL == x[2] & emp$DEPTNO == x[1], c("ENAME","SAL","DEPTNO")]
}

apply(df1,1,f_max)


# 3. data2 데이터를 읽고 
data2 <- read.csv('data2.csv', stringsAsFactors = F)
str(data2)

ff <- function(x) {
  as.numeric(str_replace_all(x,',',''))
}

data2[ ,c(3,4)] <- sapply(data2[ ,c(3,4)],ff)
str(data2)

# 1) 다음과 같이 노선별 승하차의 총 합을 표현
#     line_1  line_2  line_3  line_4
#      XXXXX   XXXXX   XXXXX   XXXXX
tapply(data2$승차 + data2$하차, data2$노선번호, sum)

# 2) 오전 오후의 승하차의 총 합을 표현
# 오전 오후
# XXXX XXXXX
tapply(data2$승차 + data2$하차, data2$시간, sum)

str_replace_all('506','[0-9][0-9]$','')
str_replace_all('1506','[0-9][0-9]$','')

data2$time <- as.numeric(str_replace_all(data2$시간,'[0-9][0-9]$',''))

v_r <- tapply(data2$승차 + data2$하차, data2$time >= 12 , sum)
names(v_r) <- c('오전','오후')
v_r

tapply(data2$승차 + data2$하차, 
       ifelse(data2$time >= 12,'오후','오전') , 
       sum)


# 정렬 : order, Doby::orderBy, sort
v1 <- c(1,10,2,5,3)
v2 <- c(1,10,2,NA,5,3)

# 1) order : 정렬된 쉘의 위치 값 리턴, 색인을 통해 정렬된 값 출력 가능
v1[order(v1)]
v2[order(v2)]
v2[order(v2, na.last = F)]  # NA를 처음으로 배치
v1[order(v1, decreasing = T)] # 내림차순 정렬

# 2) sort : 정렬된 쉘의 값이 색인 없이 바로 리턴
sort(v1)
sort(v1, decreasing = T)

# ex) emp에서 SAL이 큰 순서대로 데이터 정렬
emp <- read.csv('emp.csv', stringsAsFactors = F)
order(emp$SAL, decreasing = T)
emp[order(emp$SAL, decreasing = T),]

sort(emp$SAL, decreasing = T)

library(doBy)
orderBy(formula,data)  # 나열컬럼 ~ 정렬컬럼, 원본 data
orderBy( ~ SAL, emp)   # 포뮬러에는 반드시 컬럼명만 나열
orderBy( ~ SAL, emp, decreasing = T) # 내림차순 정렬 불가

# ex) emp에서 DEPTNO순 정렬, DEPTNO가 같은 경우  SAL 순서대로 데이터 정렬
emp[order(emp$DEPTNO, emp$SAL),]
emp[order(emp$DEPTNO, emp$SAL, decreasing = T),]
orderBy( ~ DEPTNO + SAL , emp) 

nrow(iris)

iris[sample(1:150,150),][1:100,]
iris[sample(1:150,100),]

# sample을 사용하여 랜덤하게 70% 데이터 추출
sample(1:nrow(iris),nrow(iris)*0.7)
train <- iris[sample(1:nrow(iris),nrow(iris)*0.7),]

# merge : 오라클에 조인 연산
# * 단점 : 한 번에 3개 이상의 데이터의 조인 불가, equi-join만 가능

merge(x, y, # 조인할 두 데이터 
      by = , # 조인컬럼(양쪽 컬럼이름 같을 경우)
      by.x = by, # (첫번째 데이터 조인컬럼, 조인컬럼 다수이면 벡터로 전달)
      by.y = by, # (두번째 데이터 조인컬럼)
      all = FALSE, # full outer join
      all.x = all, # left outer join
      all.y = all) # right outer join

# emp와 dept 테이블 조인
emp <- read.csv("emp.csv", stringsAsFactors = F)
dept <- read.csv("dept.csv", stringsAsFactors = F)

merge(emp, dept, by='DEPTNO')[ , c("ENAME","DEPTNO","DNAME")]
merge(emp, dept, by.x = 'DEPTNO', by.y = 'DEPTNO')

merge(student, professor, by.x = c('PROFNO',...), by.y = c('PROFNO',...),
      all.x=T)







