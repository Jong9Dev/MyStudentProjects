# 벡터의 인덱싱(색인) : 원하는 일부 추출
test1 <- 1:100
test2 <- c("aa","bb","cc")
names(test2) <- c("a","b","c")

1. 정수색인(위치기반)
test1[5]

2. 이름색인(쉘 이름기반)
test2["b"]

3. 벡터색인(여러개 추출)
test1[c(1,3,5)]
test2[c('a','c')]

4. 슬라이스색인(연속적인 중간 원소의 추출)
test1[1:5]
test2['a':'c'] # 문자의 슬라이스 색인은 불가

5. 조건색인(조건에 만족하는 원소만 추출)
test1[test1 > 50]

# 앞의 예제에서 2019년 2월 28일의 위치 확인
names(v1) <- 1:length(v1)
v1[v1=='2019-02-28']
names(v1[v1=='2019-02-28'])

# 벡터의 포함 연산자(in)
test2
test2 벡터에 'aa'가 포함되어 있는지 여부의 확인
'aa' %in% test2  # test2 각 원소별 포함 여부 확인 불가

# 벡터의 연산
vec1 <- c(1,3,5)
vec2 <- c(10,10,10)
vec3 <- c(10,20)

vec1 + 10  # 숫자형 벡터인 경우 각 원소별 산술연산 가능
vec1 + vec2 # 크기가 같은 두 벡터의 원소별 산술연산 가능 
vec1 + vec3 # 크기가 다른 두 벡터의 원소별 산술연산 가능,
            # 크기가 작은 벡터의 원소를 반복 적용하면서 연산(broadcast)

# 리스트 자료 구조 : key-value 형태로 저장되는 형식, 서로 다른 데이터 타입 허용
# 다음과 같은 자료 입력
name : smith
tel  : 02)345-6958
sal  : 4000

val1 <- c('smith','02)345-6958','4000') # 숫자인 4000이 문자로 저장
names(val1) <- c('name','tel','sal')
val1

list1 <- list(name='smith',
              tel ='02)345-6958',
              sal = 4000)         # 숫자인 4000이 숫자 그대로 저장
list1

# 리스트의 색인
list1['name']   # key 이름까지 출력
list1[['name']] # 위의 출력 결과에서 key 이름 생략하기 위함 
list1$name      # key에 매칭되는 원소만 출력

# 각 key마다 여러개 값을 갖는 list 생성
list2 <- list(name=c('smith','allen'),
              tel =c('02)123-3445', '031)234-3432'),
              sal =c(4000,5000))

# 리스트 내 특정 원소 출력
list2$tel[2]
list2[['tel']][2]

# 리스트 key 삽입
list1$gender <- 'm'

# 리스트 key 삭제
list1$sal <- NULL

# matrix 생성
1:20
m1 <- matrix(1:20,nrow=4)  # byrow = FALSE가 기본이므로 열부터 완성
m2 <- matrix(1:20,nrow=4, byrow=T)
dimnames(m1) <- list(c(1,2,3,4), c('a','b','c','d','e'))
rownames(m2) <- c(1,2,3,4)
colnames(m2) <- c('a','b','c','d','e')

# matrix 색인
m1[2,3]  # 2번째 행의 3번째 컬럼
m1[2,c(3,5)] # 2번째 행의 3,5번째 컬럼
m1[2,c('c','e')]
m1[m1 >= 10]  # 10이상인 원소 추출, 1차원 벡터로 리턴

# ex) m1의 c가 10이상인 행 출력
m1[ ,'c']       # m1의 c 컬럼 선택
m1[ ,'c'] >= 10 # m1의 c가 10이상 여부 확인 

m1[m1[ ,'c']  >= 10 , ]

# ex) m1의 e값이 20인 행의 3~5번째 컬럼 출력 
m1[m1[ , 'e'] == 20, 3:5]

# matrix 연산 
m1
rep(10,20)
m2 <- matrix(rep(10,20),nrow=4)    # 4X5
m3 <- matrix(rep(10,10),nrow=5)    # 5X2
m4 <- matrix(c(1,2,3,4,5), ncol=5) # 1X5

m1 + 10  # maxtix 원소별 스칼라 산술연산 가능
m1 + m2  # 크기가 같은 서로 다른 두 matrix의 산술연산 가능
m1 + m3  # 크기가 다른 서로 다른 두 matrix의 산술연산 불가
m1 + m4  # 컬럼 사이즈가 같아서 각 행별로 broadcast가 가능할것 같지만
         # R에서는 연산불가, 파이썬 가능
m5 <- matrix(rep(1:5,times=4), nrow = 4, byrow = T)
m1 + m5
         1 2
1 2 3 4  1 2    = 1X1 + 2X1 + ...  , 1X2 + 2X2 + ...
5 6 7 8  1 2      5X1 + 6X1 + ...  , 5X2 + 6X2 + ...
(2X4)    1 2
        (4X2)

m6 <- matrix(1:8,nrow=2,byrow = T)
m7 <- matrix(rep(1:2,each=4), nrow=4)
m6 %*% m7

# matrix 크기 확인
nrow(m7) # row 수
NROW(m7) # row 수
ncol(m7) # column 수
dim(m7)  # n X m , row와 column 수 둘다 확인 가능

dim(m1) <- c(2,10)

# matrix의 결합
v1 <- c(1,1,1)
v2 <- c(2,2,2)
v3 <- c(3,3,3)

rbind(v1,v2,v3)
cbind(v1,v2,v3)

colnames(m2) <- c('a','b','c','d','e')
colnames(m2) 
names(m2)
