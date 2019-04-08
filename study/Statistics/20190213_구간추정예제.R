v1 <- c(520, 498, 481, 512, 515, 542, 520, 518, 527, 526)

n <- length(v1)
xbar <- mean(v1)
(s <- sd(v1))
alpha <- 0.05

(weight <- qt(alpha/2, df=n-1))

xbar + (weight * (s / sqrt(n)))
xbar - (weight * (s / sqrt(n)))
