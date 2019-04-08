# decision tree in R - iris data 분류 분석
install.packages('rpart')
library(rpart)
library(doBy)

# 1. data sampling : train data set, test data set 분리
# 1-1) 그룹번호 할당을 통한 샘플링
sample(1:5,         # 원본 데이터 
       30,          # sample size
       replace = T) # 원본 데이터 수 < sample size 인 경우 반드시 필요

result <- sample(1:2, size = nrow(iris), replace = T, prob = c(0.7,0.3))
train <- iris[result == 1,]
test <- iris[result == 2,]

# 1-2) row 번호 할당을 통한 샘플링
sn <- sample(nrow(iris), size = nrow(iris) * 0.7)
train2 <- iris[sn, ]
test2 <- iris[-sn, ]

# 1-3) sampleBy 함수를 이용한 균등 샘플링
train3 <- sampleBy(~Species, frac = 0.7, data = iris)

# 균등 샘플링 여부 확인 : 종별 균등 샘플링
table(c('a','a','b','b','a'))
table(train$Species)
table(train2$Species)
table(train3$Species)

# 2. 모델 생성
m <- rpart(Species ~ . , # fomula : Y ~ X
           data=train)   # 모델 학습에 필요한 데이터 셋

m

# 3. 모델 평가
# 3-1) 새로운 데이터 셋(test)에 대한 예측력 확인
val_var <- predict(m, newdata=test, type="class") 
val_var == test$Species

# 모델의 평가점수 = TRUE 개수/TEST DATA의 전체건수 * 100
sum(val_var == test$Species)/nrow(test) * 100  # 95.55556

# 3-2) overfit(과대적합) 확인 : train set score >>> test set score
val_var <- predict(m, newdata=train, type="class") 
val_var == train$Species

# 모델의 평가점수 = TRUE 개수/TEST DATA의 전체건수 * 100
sum(val_var == train$Species)/nrow(train) * 100  # 96.19048

# 4. 모델을 통한 예측
new_data <- data.frame(Sepal.Length = 5, Sepal.Width = 3, 
                       Petal.Length = 1, Petal.Width = 0.3)

predict(m, newdata=new_data, type="class")

# 5. 모델 시각화
dev.new()
plot(m)


