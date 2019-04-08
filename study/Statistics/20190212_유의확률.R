# 가설 검정
H0 : mu = 1220
H1 : mu != 1220

t = 0.753  # 검정통계량

# 1. 기각역 확인을 통한 가설 검정
alpha = 0.05
P(X<=x) = alpha/2  <=>  qnorm(alpha/2)

n = 15
lu = qt(df=n-1,alpha/2)
ld = qt(df=n-1, 1 - alpha/2)

c(lu,ld)  # 채택역

# 2. 유의확률을 통한 가설 검정
p_value = 1 - P(X<=t)
p_value <- 1- pt(t, df=n-1)   # 0.23

# 3. t-test 검정을 통한 가설 검정
v1 <- c(1196,1340,1232,1184,1295,1247,1201,1182,1192,1287,1159,1160,1243,1264,1276)
t.test(v1, mu = 1220)



# 예제) 여아 신생아 가설 검정
r1 <- read.table('여아신생아.txt')
v1 <- unlist(r1)
xbar <- mean(v1)
s <- sd(v1)
n <- 18

1. 가설 수립
H0 : mu = 2800
H1 : mu > 2800

mu <- 2800
t <- (xbar - mu) / (s / sqrt(n))  # 2.23

2. 기각역을 통한 가설 검정
alpha = 0.05

qt(1-alpha, df=n-1)

3. 유의확률을 통한 가설 검정
p_value <- 1 - pt(t, df=n-1) # 0.02

p_value < 0.05




