install.packages('randomForest')
library(randomForest)

1. sampling

2. model 생성
forest_m <- randomForest(Species ~ ., data=iris)

randomForest(x, y=NULL,  
             xtest=NULL, ytest=NULL, 
             ntree=500,   # 트리의 개수
             mtry=n,      # 각 노드 설정 시 설명변수 후보 개수
             replace=TRUE)

forest_m$predicted # 모델을 통한 train data의 예측값
forest_m$importance # 각 feature importance(각 불순도 기반 설명변수 중요도)

# 3. 모델을 통한 예측
new_data <- data.frame(Sepal.Length = 5, Sepal.Width = 3, 
                       Petal.Length = 1, Petal.Width = 0.3)

predict(forest_m, newdata = new_data, type = 'class')

4. 모델 평가
4-1) test data에 대한 score 확인

4-2) train data에 대한 score 확인
prd_v  <- predict(forest_m, newdata = iris, type = 'class')
bool_v <- prd_v == iris$Species

sum(bool_v) / nrow(iris) * 100

# R-2차 시험범위
1. 적용함수
2. group by 연산(ddply, aggregate, tapply)
3. dcast, melt <-> stack, unstack
4. sort, order, na치환, ...
5. merge




