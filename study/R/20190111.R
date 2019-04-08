kimchi_test.csv 파일을 읽고,
kimchi <- read.csv('kimchi_test.csv', stringsAsFactors = F)

1) 각 년도별 제품별 판매량과 판매금액의 평균을 구하고
년도별 각 제품의 판매량의 증가추이를 plot 그래프로 표현
library(plyr)
data <- ddply(kimchi, .(판매년도, 제품), summarise, 
              m1 = mean(수량),
              m2 = mean(판매금액))



library(plyr)
data <- ddply(kimchi, .(판매년도,제품), summarise,
              m1 = mean(수량)
              m2 = mean(판매금액))



library(reshape2)
total <- dcast(kimchi, 판매년도 ~ 제품, sum, value.var='수량')
total1 <- dcast(kimchi, 제품 ~ 판매년도, sum, value.var='수량')
plot(total$무김치, type = 'o', col = 1,
     ann = F, axes = F, ylim = c(0,800000))
lines(total$열무김치, type = 'o', col = 2)
lines(total$총각김치, type = 'o', col = 3)

legend(1, 800000, colnames(total)[-1],
     col = 1:3, lty = 1, cex = 0.6)

axis(1, at=1:4, total$판매년도)
axis(2, ylim = c(0,800000))





plot(total$무김치, type = 'o', col = 1, 
     ann = F, axes = F, ylim = c(0,800000))
lines(total$열무김치,  type = 'o', col = 2)
lines(total$총각김치, type = 'o', col = 3)

axis(1, at=1:4, total$판매년도)
axis(2, ylim = c(0,800000))

legend(1, 800000, colnames(total)[-1],
       col = 1:3, lty = 1, cex = 0.6)

2) 각 년도별로 제품의 판매량을 비교할수 있도록 
막대그래프로 표현

row.names(total) <- total$판매년도
t(total[,-1])
t(total)

barplot(as.matrix(t(total[,-1])), beside = T,
        col = 1:3)

barplot(as.matrix(t(total[,-1])), beside = T,
        col = 1:3)

legend(1,700000, colnames(total)[-1] ,
       fill = 1:3, cex = 0.7)


# hist : 도수분포표 자동 계산후 히스토그램 출력
height <- c(182,175,167,172,163,178,181,166,159,155)
sort(height)
sample(1:3,height)

dev.new()
hist(height,main="histogram of height")
help(hist)

hist(x,                      -- 벡터
     breaks = "Sturges",     -- 구간의 분기를 나타내는 벡터
     include.lowest = TRUE,  -- 최소값의 포함 여부
     right = TRUE)           -- 오른쪽 닫힘 여부







left closed : 왼쪽포함, x <=  < y      => right = FALSE
right closed : 오른쪽 포함, x <  <= y  => right = TRUE

hist(height,
     breaks = c(150,155,160,165,170,175,180,185),
     right = TRUE) 


# pie 차트 예제
card_history파일을 대상으로 각 항목별 지출비율을 3D 파이차트로 출력
단, 각 파이의 이름은 아래와 같은 형식으로 지정
지출항목
   40%
library(stringr)
card <- read.csv('card_history.csv')

library(stringr)

f1 <- function(x) {
  as.numeric(str_replace_all(x,',',''))
}


dd <- as.data.frame(sapply(card, f1))



v1 <- apply(dd[,-1], 2, sum)

v1 <- apply(dd[,-1], 2, sum)
rate <- round(v1 / sum(v1) * 100,2)

library(plotrix)

dev.new()
lab_name <- paste(names(rate), 
                  '\n',   ##엔터와 같은 기능한다고 한듯... '\n' 
                  rate, 
                  '%', 
                  sep='')

pie3D(rate, labels = lab_name,
      labelcex = 0.8,
      radius = 0.8,
      explode = 0.05)



pie3D(rate, labels = lab_name, 
      labelcex = 0.8, 
      radius = 0.8, 
      explode = 0.05)

help(pie3D)




