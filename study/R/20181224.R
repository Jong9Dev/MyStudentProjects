# 벡터 : 1차원 데이터 셋, 동일한 데이터만 허용, 여러개의 스칼라의 결합
# 벡터의 생성 : c(원소1, 원소2, .....)
# ex : v1 <- c(1,2,3)
v1 <- c(1,2,3)
class(v1)

# 벡터의 인덱싱 : 벡터의 특정 원소만을 추출하는 과정, 원소의 주소 기반
v1[1]
v2 <- c(10,20,30)
v2[1]

v3 <- c('smith', 800, 10, 'CLERK')

v3[2] # smith의 연봉이 두번째 쉘에 있는걸 아는 경우의 색인
v3[-2] # 인덱싱에서 마이너스의 의미는 해당 쉘 제외
v3[1:2] # 슬라이스 인덱싱(색인), 연속적인 부분 추출
v3[c(1,3)] # 첫 번째 쉘과 세 번째 쉘 동시 출력, 반드시 벡터로 묶어서 전달

names(v3) <- c('name','sal','deptno','job')
v3['sal'] # 이름색인, 쉘에 이름이 부여된 경우만 가능
v3[c('sal','deptno')]  # select sal, deptno from v3;

## v3[1,3] # 첫번째 행의 3번째 컬럼 선택이라는 의미
## v3[1,c(1,3,6)] # 첫번째 행의 1,3,6번째 컬럼 선택이라는 의미

# factor 변수 생성
1)
var1 <- factor('a',c('a','b','c'))
2)
var2 <- 'a'
factor(var2,c('a','b','c'))
3)
var3 <- c('a','b','a','c')
var3 <- factor(var3)
levels(var3) <- c("A","B","c")
var3

# factor 여부 확인
is.factor(var1) #true
is.factor(var2) #false

# factor 변수의 level 확인
levels(var1)
levels(var1)[1] # 첫 번째 레벨 확인

# factor 변수의 level 수정
levels(var1) <- c("aa","bb","cc")

var3 <- c('남','여','남','남','여')
factor(var3)

# as.Date() : 문자 -> 날짜로 인식
date1 <- seq(as.Date('20181201','%Y%m%d'),
             as.Date('20181231','%Y%m%d'),1)

# date1 날짜 표현식에서 각 년도만 출력
# 날짜의 포맷 변경은 오라클에서 to_char, R에선 as.character
as.character(date1,'%Y')

# date1 날짜 표현식에서 각 요일만 출력
# help(strptime) 통해서 날짜 포맷 확인 가능
as.character(date1,'%w')

# 참고 : 변수 생성과 동시에 출력 방법
var10 <- 11 ; var10  # ;은 명령어의 연속 출력을 의미
(var10 <- 11)        # (명령어) 동시에 명령어 실행과 출력 수행


문제1) 2019년 1월 날짜 데이터를 생성
v1 <- seq(from=as.Date('2019/01/01','%Y/%m/%d'),
          to=as.Date('2019/01/31','%Y/%m/%d'),
          by=1)

문제2) 5,6번째 데이터 추출
v1[5:6]
v1[c(5,6)]

문제3) 위의 데이터를 1년 후 데이터로 수정
v1[c(5,6)] <- v1[c(5,6)] + 365

length(v1) # 벡터의 원소의 개수
NROW(v1)   # 행의 수, 벡터 가능(벡터는 원소의 개수 출력)
nrow(v1)   # 행의 수, 벡터 불가능

문제4) v1에 마지막 쉘에 v1 마지막날짜의 다음날을 삽입
v1 <- c("2019-01-01", "2019-01-02", ......., "2019-01-31", "2019-02-01")
class(v1)

v1 <- c(v1,as.Date("2019-02-01","%Y-%m-%d"))

v1 <- c(v1,
        v1[length(v1)] + 1)  # 마지막 날짜 추출 후 다음날 계산

v1 <- append(v1,
             v1[length(v1)] + 1)  # 벡터의 원소 추가(확장)

# 벡터의 원소 추가(확장) 예
v3 <- c(1,2)
v3 <- append(v3,3)
v3
