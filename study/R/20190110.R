# plot 그래프 그리기
x1 <- c(1,3,5)
y1 <- c(10,5,1)

plot(x1,y1, type = 'o')
plot.new() # figure(도화지) reset
dev.new()  # figure 창 생성
plot(x1,y1, type = 'o')

plot(x1,y1, type = 'b', 
            xlim = c(1,10),
            ylim = c(1,20))

plot(x1)
axis : x축, y축 눈금 개수 변경, 이름 지정
axis(1,at=1:3, lab=c('A','B','C')) -- 기존 축 이름과 겹침

dev.new()
plot(x1, ann = F, axes = F, 
     ylim = c(1,10) , col = 'red', type = 'b',
     xlab = 'abc', ylab = '개수')

axis(1, at=1:3, lab=c('A','B','C'))
axis(2, ylim = c(1,5))

v1 <- c(1,2,3,4,5)
v2 <- c(2,4,6,8,10)
v3 <- c(1,5,6,2,1)
dev.new()
plot(v1, type = 'o', col = 'red')
par(new = T)
plot(v2, type = 'o', col = 'blue')
par(new = T)
plot(v3, type = 'o', col = 'black')

plot(v1, type = 'o', col = 'red', ylim = c(1,12))
lines(v2, type = 'o', col = 'blue')
lines(v3, type = 'o', col = 'black')

dev.new()
plot(card[,2],type = 'o', 
     col = 1, ylim = c(0,300000),
     axes = F)
lines(card[,3],type = 'o', col = 2)
lines(card[,4],type = 'o', col = 3)
lines(card[,5],type = 'o', col = 4)
lines(card[,6],type = 'o', col = 5)
lines(card[,7],type = 'o', col = 6)

axis(1, at=1:30)
axis(2,ylim = c(0,300000))
legend(2,290000, colnames(card)[-1], 
       cex = 0.8, col = 1:6, lty = 1 )

# plot 연습 문제
subway2.csv 파일의 데이터를 기반으로
승차가 가장 많은 top 5개의 역을 구하고 
각 역의 시간대별 승차의 증감추세를 도표화 하여라

sub <- read.csv('subway2.csv', skip = 1)

df1 <- sub[sub$구분 == '승차', ]

f3 <- function(data,x=',',y='') {
  as.data.frame(sapply(data,str_replace_all,x,y))
}

df2 <- f3(df1[,-c(1,2)])  # 사용자 정의함수 사용,천단위 구분기호 제외
df1[,-c(1,2)] <-  apply(df2,2,as.numeric)
head(df1)
str(df1)

apply(df1[,-c(1,2)], 1, sum)  # 역별 승차 총 합(벡터)
total <- df1[order(apply(df1[,-c(1,2)], 1, sum), decreasing = T)[1:5], ]

dev.new()
plot(t(total[1,-c(1,2)]/10000), 
     type = 'o', col = 1, ylim = c(0,40),
     ann = F, axes = F)
lines(t(total[2,-c(1,2)]/10000), type = 'o', col = 2)
lines(t(total[3,-c(1,2)]/10000), type = 'o', col = 3)
lines(t(total[4,-c(1,2)]/10000), type = 'o', col = 4)
lines(t(total[5,-c(1,2)]/10000), type = 'o', col = 5)

v1 <- substr(colnames(total)[-c(1,2)], 2, 3)

axis(1, at=1:length(v1), lab = v1)
axis(2, ylim = c(0,40))

legend(length(v1) - 4,
       40,
       total$전체,
       col = 1:5,
       lty = 1)

title(main = "역별 승차 인원", xlab = '시간', ylab = '승차수(단위 : 만)')







