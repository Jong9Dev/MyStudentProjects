data.table 
DB에서 table구조가 특정 컬럼별 주로값을 갖는 index를 생성하여
key를 통한 연산 및 검색을 빠르게 수행할 수 있는 점을 재현한 구조
다음의 연산 등이 빠름
- key를 통한 조건 검색(색인)
- key를 통한 그룹 연산
- key를 통한 정렬

1. table 생성
iris_big <- c()
for ( i in 1:1000 ) {
  iris_big <- rbind(iris_big, iris)
}
nrow(iris_big)

2. key 설정
library(data.table)
iris_big_table <- as.data.table(iris_big)
setkey(iris_big_table, Species)  # Species의 값별 주소를 갖는 index 저장

3. 속도 테스트
3-1) iris_big의 종별 평균 수행(data frame구조)
library(plyr)

system.time(a<-1)
system.time(ddply(iris_big, .(Species), summarise, m1 = mean(Sepal.Length),
                                                   m2 = mean(Sepal.Width)))

3-2) iris_big_table의 종별 평균 수행(table구조)
system.time(ddply(iris_big_table, .(Species), summarise, 
                  m1 = mean(Sepal.Length),
                  m2 = mean(Sepal.Width)))










