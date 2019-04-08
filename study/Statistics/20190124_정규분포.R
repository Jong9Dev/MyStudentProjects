dbinom(3,10,0.1) # 확률질량함수
dbinom(3.3,10,0.1)

# d함수
- 확률질량함수 또는 확률밀도함수 제공
- 확률변수 X가 x일때의 매칭되는 y값(확률) 제공
- P(X=x) 값 제공
- ex) dbinorm, dnorm, dt ......

# p함수
- P(X<=x) 값 제공
- ex) pbinom, pnorm, pt .....

# q함수
- P(X<=x) = p를 갖는 x값 출력
- 이항분포에서 성공횟수가 몇 회 이하일 확률이 50%일까?
- ex) qbinom, qnorm. qt .....

# 이항분포 테스트
# 1. n=10, p=0.1인 이항분포 출력
dbinom(0, 10, 0.1) # P(X=0)
dbinom(1, 10, 0.1) # P(X=1)
dbinom(2, 10, 0.1) # P(X=2)
...

p1 <- dbinom(0:10, 10, 0.1) # P(X=x), 0<=x<=10
dev.new()
plot(0:10, p1, type = 'l')

# 2. 위의 이항분포에서 성공횟수가 2회 이하일 확률(P(X<=2))
# P(X=0) + P(X=1) + P(X=2)
dbinom(0, 10, 0.1) + dbinom(1, 10, 0.1) + dbinom(2, 10, 0.1)
pbinom(2,10,0.1)

# 3. P(X<=x) 구간 그래프 그리기
plot(0:10, p1, type = 'l', ylim = c(0,0.5))
abline(v=2) # 수직선
abline(h=0) # 수평선

# arrows(x_start, y_start, x_end, y_end, length) : 화살표 그리기
arrows(2,0.45, 1.5, 0.45, length = 0.1)

# text(x,y,text) : 그래프 위에 글자 출력
text(0.8, 0.45, "P(X<=2)")

# (0,0) , (0,f(0)), (1,f(1)), (2,f(2)), (2,0)
# polygon(vector_x, vector_y, col)

f <- function(x) {
  dbinom(x, 10, 0.1)
}

polygon(c(0,0,1,2,2),
        c(0, f(0), f(1), f(2), 0),
        col = 'red')

# 4. P(X<=a) = p 인 값 찾기
qbinom(0.8, 10, 0.1)

# 5. P(X<=a) = 0.8을 만족하는 임계값(a) 시각화
dev.new()
par(mar=c(5,3,1,1))
plot(0:10, p1, type = 'l', ylim = c(-0.05,0.5), ann = F, axes = F)
axis(2, ylim= c(-0.05,0.5))
abline(h=0) # 수평선

polygon(c(0,0,1,2,2),
        c(0, f(0), f(1), f(2), 0),
        col = 'red')
text(1,0.2,'80%')
arrows(2,-0.02, 2, 0, length = 0.1)
text(2, -0.03, '?', cex = 2)


# [ 정규 분포 ]
# - 확률변수 X와 그 확률과의 관계가 종모양을 띄는 경우
# - 표준정규분포 : 평균으로 뺀 값을 표준편차로 나눈 표준화된 값이
#   가지는 분포  X ~ N(0,1)

# 정규분포 그리기
x1 <- seq(-3,3,0.01)
y1 <- dnorm(x1, 0, 1 )

dev.new()
plot(x1,y1,type = 'l', col = 'red', ann = F, axes = F)
abline(h=0)
abline(v=0, lty=2)  # lty=2 : 점선











