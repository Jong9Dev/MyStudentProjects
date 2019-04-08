# decision tree in R - cancer data 분류 분석
read.csv('cancer.csv')
# 1. sampling
table(cancer$diagnosis)

sn <- sample(nrow(cancer), size = nrow(cancer) * 0.7)
train <- cancer[sn, ]
test  <- cancer[-sn, ]

table(train$diagnosis)

train2 <- sampleBy(~diagnosis, frac = 0.7, data = cancer)
table(train2$diagnosis)

# 종속변수가 각 class별로 균등하지 않으면 예측력이 떨어질 가능성이 높음
# upsampling : 도수가 더 높은쪽으로 균등하게 맞추는 작업, 복원추출됌
# downsampling : 도수가 더 낮은쪽으로 균등하게 맞추는 작업

library(caret)
caret::upSample(x,y)
caret::downSample(x,y)

usample <- upSample(cancer[, -c(1,2)], 
                    cancer[, 2])

table(usample$Class)
table(cancer$diagnosis)

# 2. model train
m <- rpart(diagnosis ~ . , 
           data=cancer)

# 3. model tuning
# minbucket 변화에 따른 score 점수 변화추이 분석

for ( i in 1:10 ) {
  m <- rpart(diagnosis ~ . , 
             data=cancer,
             control = rpart.control(minbucket = i))
  val_var <- predict(m, newdata=test, type="class") 
  equal_v <- val_var == test$diagnosis
  score_v <- c(score_v, sum(equal_v)/nrow(test) * 100)
}

plot(1:10, score_v)

# 4. model plot
