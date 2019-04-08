# 표본과 모집단의 관계
# 모집단이 평균이 mu, 표준편차가 sigma인 정규분포일 경우
# 모집단으로 부터 추출한 표본의 크기가 n인 표본의 평균은
# 확률변수로써 ~ N(mu, sigma/sqrt(n))

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
  s1[i] <- mean(rbinom(4, size = 100, prob = 0.5))
  s2[i] <- mean(rbinom(10, size = 100, prob = 0.5))
  s3[i] <- mean(rbinom(100, size = 100, prob = 0.5))
} 

# 2-2) 정규분포와의 근사성 확인






