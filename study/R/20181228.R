v1 <- ...

1. next문장 수행 시
for ( i in 1:10 ) {
  cmd1
  cmd2
  if ( i == 5 ) {   # i가 5이면 cmd3 생략 for문 정상 작동, cmd4 정상 작동
    next
  } 
  cmd3
}
cmd4

2. break 문장 수행 시
for ( i in 1:10 ) {
  cmd1
  cmd2
  if ( i == 5 ) {  
    break         # i가 5가 되는 순간부터 cmd3뿐 아니라 
  }               # 반복문 내 모든 명령어 무시, cmd4 정상 수행
  cmd3
}
cmd4

3. exit 문장 수행 시
for ( i in 1:10 ) {
  cmd1
  cmd2
  if ( i == 5 ) {
    exit 0      # 즉시 종료, cmd4 무시
  } 
  cmd3
}
cmd4


# stringr 패키지 : 문자열 함수
library(stringr)
1. str_detect : 원소별 패턴 검사(오라클의 like연산자와 비슷)
v1 <- c('aa','ba','ccb','Ab')
v1[str_detect(v1,'a')]   # 순서 상관없이 'a'를 포함하는
v1[str_detect(v1,'^a')]  # 'a'로 시작하는
v1[str_detect(v1,'a$')]  # 'a'로 끝나는
v1[str_detect(v1,'^[aA]')] # 대소 상관 없이 a로 시작하는
v1[str_detect(v1,'^[aAbB]')] # 대소 상관 없이 a또는 b로 시작하는
v1[str_detect(v1,'^[aA][bB]')] # 대소 상관없이 a로 시작, 두번째가 b

# [aA] : a or A (문자열 표현식에서의 []는 하나의 글자 패턴 완성)

# emp에서 이름이 S로 시작하는 직원의 정보 출력
emp[str_detect(emp$ENAME, '^[sS]'),]

v1[c(T,F,F)]
emp[ c(T,F,F,.....)  , c(T,F,F,.....) ]


2. str_locate
str_locate('abab','a')  # 첫 번째 'a'의 위치, 시작위치 끝 위치 같음
str_locate('aabab','a')  # 첫 번째 'a'의 위치, 시작위치 끝 위치 같음
str_locate('aabab','aa')  # 첫 번째 'aa'의 위치, 시작위치 끝 위치 다름
class(str_locate('abab','a'))

v3 <- c('a)','ab)a','b)','aba)bab')
str_locate(v3,'\\)')

v3 <- c('a','aba','b','ababab')
str_locate_all(v3,'a')[[2]][2,1]  # 두번째 원소의 두번째 a의 위치

# 3. str_replace
v4 <- c('1,100','1,002,300','3,900')
v4 + 100  # v4가 문자열이라 연산 불가
v4 <- str_replace_all(v4,',','')  # 모든 천단위 구분기호 삭제
as.numeric(v4) + 100  # 삭제하더라도 여전히 문자이므로 숫자로 형 변환 필요

# student.csv 파일을 읽고
student <- read.csv("student.csv")
library(stringr)
# 1. TEL 컬럼을 사용하여 지역번호 추출
str_sub(student$TEL,
        1,
        str_locate(student$TEL,'\\)')[,1] - 1)

str_locate(student$TEL,'\\)')[,1] - 1   # ')'의 위치 - 1

str_split(student$TEL,'\\)')[[1]][1]

v1 <- c()
for (i in 1:length(student$TEL)) {
  v1 <- c(v1,str_split(student$TEL,'\\)')[[i]][1])
}
v1

# 2. 여학생 정보만 추출
student[str_sub(student$JUMIN,7,7) == "2", ]

# 3. 위의 변환식을 활용하여 성별 컬럼 추가("남자","여자")
student$성별 <- ifelse(str_sub(student$JUMIN,7,7) == "2","여자","남자")

v2 <- c()
for (i in str_sub(student$JUMIN,7,7)) {
  if (i == "2") {
    v2 <- c(v2,"여자")
  } else {
    v2 <- c(v2,"남자")
  }
}
student$성별2 <- v2
