[ 이항 분포 ]
베르누이 시행 시 성공할 확률이 각 반복마다 동일할때
성공한 횟수(확률변수)가 취할 수 있는 확률분포를 이항분포라 정의함
X ~ B(n,p)

1. 이항분포 test
동전 던지는 시행을 10회 반복, 앞면이 나오는 사건, 
각 확률변수가 취하는 분포 확인

# 각 확률을 직접 계산
n <- 10
p <- 0.5
FFFFFFFFF => 0.5 * 0.5 * 0.5 * ......
P(X=0) = 10C0 * (0.5)^0 * (0.5)^10 = choose(10,0) * (0.5)^0 * (0.5)^10
P(X=1) = 10C1 * (0.5)^1 * (0.5)^9 = choose(10,1) * (0.5)^1 * (0.5)^9
HFFFFFFFFF = (0.5)^1 * (0.5)^9
FHFFFFFFFF = 
FFHFFFFFFF
.....

P(X=4) = choose(10,4) * (0.5)^4 * (0.5)^6

# 이항분포의 확률 밀도함수를 사용한 확률 계산
dbinom(4,size = 10, prob = 0.5)  # 10회중 4번 성공할 확률
b1 <- dbinom(0:10,size = 10, prob = 0.5) 

# 이항분포의 시각화
dev.new()
barplot(b1)
plot(b1, type = 'l')

# n의 변화에 따른 이항분포 비교
p <- 0.3
x1 <- 0:5
x2 <- 0:10
x3 <- 0:30

p1 <- dbinom(x1,5,p)
p2 <- dbinom(x2,10,p)
p3 <- dbinom(x3,30,p)

plot(x3, p3, type = 'l', col = 'black', ylim = c(0,0.4))
lines(x2, p2, type = 'l', col = 'blue', ylim = c(0,0.4))
lines(x1, p1, type = 'l', col = 'red', ylim = c(0,0.4))





