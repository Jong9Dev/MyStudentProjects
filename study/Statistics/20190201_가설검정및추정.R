1. 
A사 K모델 자동차의 연비는 평균 12.5(km/l), 표준편차 0.5(km/l)로 
알려져 있는데, 새로 개발된 엔진을 장착한 40대의 자동차 연비를 
측정한 결과 표본평균이 12.64(km/l)로 나왔다. 

1-1)
새로 개발된 엔진의 연비의 95% 신뢰수준(0.05 유의수준) 하 신뢰구간을 구해보자

alpha = 0.05
a = abs(qnorm(alpha/2, mean=0, sd=1))
xbar = 12.64
sigma = 0.5
n = 40

su = xbar + a * (sigma / sqrt(n))
sl = xbar - a * (sigma / sqrt(n))

c(sl, su)

1-2) 99% 신뢰수준 하 신뢰구간

alpha = 0.01
a = abs(qnorm(alpha/2, mean=0, sd=1))
xbar = 12.64
sigma = 0.5
n = 40

su = xbar + a * (sigma / sqrt(n))
sl = xbar - a * (sigma / sqrt(n))

c(sl, su)


2. 
랜덤하게 샘플링한 초콜릿 16개 무게의 표본평균이 199.5(g), 
표본분산이 25.0이었을 때, 모평균에 대한 95% 신뢰구간을 구하시오.

alpha = 0.05
a = abs(qnorm(alpha/2, mean=0, sd=1))
xbar = 199.5
sigma = 5
n = 16

su = xbar + a * (sigma / sqrt(n))
sl = xbar - a * (sigma / sqrt(n))

c(sl, su)

