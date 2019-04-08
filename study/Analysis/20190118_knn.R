# 유클리안 거리 계산 법
cancer <- read.csv('cancer.csv')
p1 <- c(1, 10, 2.5, 3.9)
q1 <- c(2, 9,  2.3, 100)

d_pq <- sqrt((1-2)^2 + (10-9)^2 + (2.5-2.3)^2 + (3.9-3.1)^2)

# 거리기반 모델의 특징
- 거리는 각 설명변수의 스케일에 민감 => 스케일 조정 필요
  ** standard scale : X - xbar / se 
  ** min-max scale : 최대값을 1, 최소값을 0으로 변경
- 이상치(outlier)에 민감 => 이상치 데이터 제어 필요(제거 또는 수정)
- NA에 민감 
- 선택된 변수에 매우 민감(모델 내 변수 선택 과정이 없기때문)

# 스케일 조정 필요성
- 각 변수마다 범위가 다르거나, 분포가 다르면 각 변수의 차이를 해석하기 어려움
ex)
x1 <- c(1,2,3,3,4,4,3,4,5,3,10)
x2 <- c(1,10,11,19,29,5,3,4,20,30)

x1[2] - x1[3] # 1
x2[2] - x2[3] # 1

s1 <- scale(x1)
s2 <- scale(x2)

s1[2] - s1[3] # 0.43
s2[2] - s2[3] # 0.09

# knn 
- 새로운 예측 관측치(정답을 알고자 희망)와 기존 관측치(정답을 이미 알고있는)
  사이의 거리를 계산하여 가장 가까운 k개의 관측치들의 class를 확인하여 예측
- k값이 클수록 예측력 증가
- 이중분류인 경우는 k가 짝수일 경우 낮은 예측을 보일 수 있음

# [ knn in R - cancer data ]
cancer <- read.csv('cancer.csv')
1. sampling - caret::createDataPartition에 의한 샘플링
library(caret)
cancer <- upSample(cancer[,-c(1,2)], cancer$diagnosis, yname = 'diagnosis')
table(cancer$diagnosis)

# sample함수로 추출 시 균등 샘플링 여부 확인
rn1 <- sample(1:nrow(cancer), size = nrow(cancer) * 0.7 )
train1 <- cancer[rn1,]
table(train1$diagnosis)  # 대체적으로 균등하나 그렇지 않은 경우도 있음

# createDataPartition 함수로 추출 시 균등 샘플링 여부 확인
rn2 <- createDataPartition(y=cancer$diagnosis, p=0.7, list = F)
train2 <- cancer[rn2,]
test2 <- cancer[-rn2,]

table(train2$diagnosis)  # 항상 class별 균등하게 샘플링 됌

2. model fit
train_x <- train2[ , !colnames(train2) %in% 'diagnosis']
train_y <- train2[ , 'diagnosis']

test_x <- test2[ , 1:30]
test_y <- test2[ , 'diagnosis']

3. model 평가
library(class)

knn_model1 <- knn(train_x, test_x, train_y, k=3)
sum(knn_model1 == test_y)/ nrow(test_x) * 100  

knn_model2 <- knn(train_x, test_x, train_y, k=5)
sum(knn_model2 == test_y)/ nrow(test_x) * 100 

4. k의 수 튜닝
1) train set score
score_v1 <- c()
for (i in 1:20){
knn_model1 <- knn(train_x, train_x, train_y, k=i, prob = T)
score_v1[i] <- sum(knn_model1 == train_y)/ nrow(train_x) * 100
}
  
legnth(score_v)

2) test set score
score_v2 <- c()
for (i in 1:20){
  knn_model1 <- knn(train_x, test_x, train_y, k=i, prob = T)
  score_v2[i] <- sum(knn_model1 == test_y)/ nrow(test_x) * 100
}

score_v2

# 시각화
dev.new()
plot(score_v1, type = 'o', 
     col = 1, xlab='number of k', ylim = c(90,100))
lines(score_v2, type = 'o', col = 2)











