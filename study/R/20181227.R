a1 <- array(1:20, c(2,5,2))

a2 <- array(1:20)
dim(a2) <- c(2,5,2)

a1[1,,1]    # 한 번의 색인과정을 통해 추출
a1[,,1][1,] # 두 번의 색인과정을 통해 추출(위와 결과 같음)


# data frame 생성
no <- c(1,2,3,4)
name <- c('apple', 'banana','peach','berry')
price <- c(500,200,200,50)
qty <- c(5,2,7,9)

df1 <- data.frame(no = no, name = name, price = price, qty = qty)

str(df1) # name 컬럼 factor 변수
#data.frame으로 데이터프레임 만들때 문자열 컬럼은 자동으로 factor형으로 생성

df1
rbind(df1,c(5,'mango',100,10)) #마지막 행 추가 시, factor형 level로 선언되지
                               #않은 값은 NA처리
# mango data 삽입을 위해
# 1. data frame 생성시 문자열 컬럼을 factor로 생성하지 X
df2 <- data.frame(no = no, name = name, price = price, qty = qty,
                  stringsAsFactors = F)
str(df2)
df2 <- rbind(df2,c(5,'mango',100,10))

# 2. 이미 생성된 data frame의 factor형 컬럼을 일반 문자열 컬럼으로 변경
df1$name <- as.character(df1$name)
str(df1)
df1 <- rbind(df1,c(5,'mango',100,10))

# 이미 생성된 data frame의 문자열 컬럼을 factor형으로 변경
df1$name <- factor(df1$name)
str(df1)
df1

# banana를 BANANA로 수정
df1[2,2] <- 'BANANA'                # NA로 변경 됌
df1$name <- as.character(df1$name)  # 일반 문자열 컬럼으로 변경 후
df1[2,2] <- 'BANANA'                # 다시 수정

# 컬럼 추가
df1$area <- c('a','b','c','a','b')  # 컬럼 추가시 문자열 컬럼 factor로 생성X
area2 <- c('a','b','c','a','b')
df1 <- cbind(df1,area2) # cbind로 문자열 컬럼 생성 시 factor로 생성
str(df1)

# 차원의 축소 : 높은 차원에서 낮은 차원으로 데이터가 변경되서 출력되는 현상
# (3차원 -> 2차원 또는 1차원, 2차원 -> 1차원)
df1$name
df1[,'name',drop=F]

# %in% 연산자
# 이름이 apple과 peach인 행 선택
# where name in ('apple','peach')
c('apple','peach') %in% df1$name # apple과 peach의 name컬럼에의 존재 여부 확인
df1$name %in% c('apple','peach') # name의 각 행이 
                                 # c('apple','peach')에 있는지 여부 확인

colnames(df1)
names(df1)

head(df1,2)
df1[1:2,]

m1 <- cbind(no,name,price,qty)
as.data.frame(m1)

# 외부 csv파일 불러오기
getwd()
emp <- read.csv('emp.csv')
str(emp)
# 1. empno가 7900인 사원의 이름, sal 출력
emp[emp$EMPNO == 7900, c('ENAME','SAL')]

# 2. 1월에 입사한 사람의 이름, 입사일, 연봉 출력
as.character(as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M'),
             '%m')

emp[as.character(as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M'),'%m') == '01',
    c('ENAME','HIREDATE','SAL')]

# 3. SMITH와 SCOTT의 연봉 출력
emp[emp$ENAME == 'SMITH' | emp$ENAME == 'SCOTT', 'SAL']
emp[emp$ENAME %in% c('SMITH','SCOTT'),'SAL']

# 4. 다음의 계산식으로 퇴직금 계산 후 R_PAY 컬럼으로 추가
#    (퇴직금 = 현재 SAL * trunc(근속년수/12))
var1 <- Sys.Date() - as.Date(emp$HIREDATE,'%Y-%m-%d %H:%M') # 총근무일수
wyear <- trunc(var1/365)
emp$R_PAY <- as.numeric(emp$SAL * trunc( wyear /12 ))
class(var1)

# if문(조건문, 벡터 연산 불가)
# if문은 벡터의 원소별 조건 치환이 불가 => for문 사용, ifelse 함수 사용

vec1 <- c(10,20,30)

if ( vec1 == 10 ) {
  print("인사부")
} else {
  print("총무부")
}      # 결과값이 인사부인 이유 : 맨 첫 요소인 10에 대해서만 조건 치환 적용

# ifelse (조건문, 벡터 연산 가능)
# 벡터의 원소별 조건 검사 가능, 조건별 명령어의 수행은 불가(only 출력)
ifelse(vec1 == 10,'인사부','총무부')
             # in oracle : decode(vec1,10,'인사부','총무부')

ifelse(vec1 == 10,'인사부',
                  ifelse(vec1 == 20, '재무부','총무부'))

# emp data frame에서 deptno를 기반으로 부서명을 갖는 dname 컬럼 추가
# (10 : 인사부, 20 : 재무부, 30: 총무부)

emp$dname <- ifelse(emp$DEPTNO == 10,
                    '인사부',
                    ifelse(emp$DEPTNO == 20,
                           '재무부',
                           '총무부'))

# if문의 else if 구문
if ( vec1 == 10 ) {
  print("인사부")
} else if ( vec1 == 20 ) {
  print("재무부")
} else {
  print("총무부")
}

# deptno 가 10이면서 sal이 4000이상인 사람은 "임원후보"로 출력
# 1) if문
if ((emp$DEPTNO == 10) & (emp$SAL >= 4000 )) {
  print("임원후보")
} else {
  print("임원후보아님")
}

# &  : 여러개의 논리연산 가능
# && : 단 하나의 논리연산 가능
c(T,F) & c(F,F)
c(T,F) && c(F,F)

# 2) ifelse문
ifelse(emp$DEPTNO == 10 & emp$SAL >= 4000 ,'임원후보','임원후보아님')


# for문(반복문, 반복횟수 정해져 있음)
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
    print("인사부")
  } else {
    print("총무부")
  }
}

# emp에서 sal이 2000이상일 경우는 연봉 인상률이 10%,
# 2000미만일 경우는 15%로 계산(for문 내 print로는 컬럼 저장 불가)

emp$NEW_SAL <- for (i in emp$SAL) {
  if (i >= 2000) {
    print(i * 1.1)
  } else {
    print(i * 1.15)
  }
}
