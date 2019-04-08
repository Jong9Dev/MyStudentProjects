# 표본과 모집단의 관계
# 모집단이 평균이 mu, 표준편차가 sigma인 정규분포일 경우
# 모집단으로 부터 추출한 표본의 크기가 n인 표본의 평균은
# 확률변수로써 ~ N(mu, (sigma/sqrt(n))^2)

# 표본평균의 평균 => "모집단의 평균"과 유사해짐
# 표본평균의 분산 => "모집단의 분산 / n" 과 유사해짐
# 표본평균의 분포는 정규분포와 유사해짐...

# 1. 모집단이 정규분포를 따르는 경우
# 1-1) 표본평균의 분포 확인(히스토그램)
set.seed(9)

s1 <- c()
s2 <- c()

for (i in 1:1000) {
  s1[i] <- mean(rnorm(100,mean=4, sd=2))
  s2[i] <- mean(rnorm(100,mean=10, sd=1))
}

dev.new()
hist(s1, prob = T)
hist(s2, prob = T)

# 1-2) 정규분포와의 근사성 확인
x1 <- seq(min(s1),max(s1),0.01)
y1 <- dnorm(x1, mean = 4 , sd = 2/10)

lines(x1, y1, type = 'l', col = 'red')

x2 <- seq(min(s2),max(s2),0.01)
y2 <- dnorm(x2, mean = 10 , sd = 1/10)

lines(x2, y2, type = 'l', col = 'red')

dev.new()
par(mfrow=c(1,2))

# 2. 모집단이 이항분포를 따르는 경우
# X ~ B(n,p)일 경우 x의 평균은 np, x의 분산은 npq

# 1-1) 표본평균의 분포 확인(히스토그램)
set.seed(9)

s1 <- c()
s2 <- c()
s3 <- c()

for (i in 1:1000) {
  s1[i] <- mean(rbinom(4, size = 100, prob = 0.5))  # mu = 100 * 0.5
  s2[i] <- mean(rbinom(10, size = 100, prob = 0.5)) # sigma = sqrt(100 * 0.5 *0.5)
  s3[i] <- mean(rbinom(100, size = 100, prob = 0.5))
} 

dev.new()
par(mfrow=c(1,3))
hist(s1, prob = T)
hist(s2, prob = T)
hist(s3, prob = T)

# 2-2) 정규분포와의 근사성 확인
x1 <- seq(min(s1), max(s1), 0.01)
x2 <- seq(min(s2), max(s2), 0.01)
x3 <- seq(min(s3), max(s3), 0.01)

mu = 100 * 0.5
sigma = sqrt(100 * 0.5 *0.5)

y1 <- dnorm(x1, mean = mu , sd = sigma / sqrt(4))
y2 <- dnorm(x2, mean = mu , sd = sigma / sqrt(10))
y3 <- dnorm(x3, mean = mu , sd = sigma / sqrt(100))

lines(x1,y1, type = 'l', col = 'red')
lines(x2,y2, type = 'l', col = 'red')
lines(x3,y3, type = 'l', col = 'red')


# 중심극한정리에 의하면 모집단이 어떤 분포이던 
# 그로 부터 반복 추출된 집단(표본)의 평균들은 
# 1. 모집단의 평균 근처에 밀집될 확률이 높다
# 2. 표본의 크기(n)가 클수록 모집단의 평균 근처에 분포될 확률은 높아짐
#    (분산이 작아짐)
# 3. 확률변수 xbar(표본평균)의 분포는 정규분포에 근사
#    평균이 mu(모평균), 
#    표준편차가 sigma(모표준편차)/sqrt(n) (n:sample size)인 정규분포


# [ 표준 정규 분포 ]
X ~ N(mu, sigma^2) 인 정규분포를 표준화 하면,
X ~ N(0,1)의 분포를 가지며 이 분포를 표준정규분포라 함

만약 xbar ~ N(mu, (sigma/sqrt(n))^)
Z = (xbar - mu) / (sigma/sqrt(n))

# 1. 표준정규분포 곡선 시각화
x1 <- seq(-3,3,0.01)
y1 <- dnorm(x1, mean = 0, sd = 1)

dev.new()
plot(x1,y1, type='l')

# 2. 표준정규분포의 특징
# 1. P(X <= 0 ) = 0.5
pnorm(0, mean = 0, sd = 1)

# 2. P(-1.96 <= X <= 1.96) = 0.95 <=> P(X <= -1.96) = 0.025
pnorm(-1.96, mean = 0, sd = 1)
qnorm(0.025, mean = 0, sd = 1)


예제) 랜덤하게 추출된 10명의 키의 평균이 175일때 모집단 추정?
  (단 모집단의 평균이 177이고 분산이 5인것을 알고 있을 경우)

ho : mu = 180





