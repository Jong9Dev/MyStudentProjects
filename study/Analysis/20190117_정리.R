# [ 기계 학습의 분류 ]
- 지도 학습 : 예측하고자 하는 값(Y, 종속변수)이 반드시 필요
 1) 회귀분석
   - y가 연속형인 경우
   - 통계적 가설에 의한 모델
   - R-square, p-value ... 모델을 평가하는 통계량 제시(해석필요)
   - 인과관계 파악 가능 : 회귀식 추정을 통한 회귀계수 확인 가능
      Y = a1X1 + a2X2 + .... + anXn + b (n개의 설명변수)
      X1  ~ a2X2

      
 2) 분류분석
   - y가 범주형인 경우
   - 통계적 가설이 필요 없음
   - 통계적 모델 평가 기법 불가 => 검정데이터를 사용한 모델의 평가
   - 트리기반 모델을 제외하고는 대부분 black box 모델
     => 모델 내부를 확인할 수 없음
     => 인과관계 파악 불가

- 비지도 학습 : 예측하고자 하는 값이 없이 데이터를 세분화 하거나 연관성 파악
 1) 군집분석
 2) 연관분석


# [ 분석의 단계 ]
1. 목적
2. 데이터 수집 : 종속변수가 포함된 데이터 필요(지도학습일 경우),
또한 종속변수에 영향을 미칠만한 발생 가능한 모든 데이터의 수집 필요
 
3. 기본적 데이터 전처리
- NA, NULL 처리
- 필요 데이터의 추출 및 치환
- 구간분할 : 연속형 변수의 factor화
  ex) 성적을 상중하 그룹으로 분류해서 모델에 적용

4. feature selection(변수의 선택)
- 경험적 선택(전문가의 견해)
- 모델을 통한 선택
 1) feature selection model
 2) decision tree, regressor 처럼 모델을 학습하는 과정에서 발견된
    feature importance를 활용한 선택
 3) 대부분의 딥러닝 모델은 내부에서 자동 변수 선택 과정을 거침
  
5. 모델 선택 및 학습을 통한 생성
- train data set으로 모델 학습
- test data set은 모델 평가용으로 따로 분리

6. 모델 튜닝 및 평가
- 목적 : 정확도 개선, 일반화(overfit 해소)
- 각 모델들 마다 매개변수 값을 조절하면서 모델에 대한 튜닝이 이루어 짐
- 매개변수의 선택은 정확도를 개선하는 측면도 있지만
  모델의 일반화를 위해 사용되는게 일반적

7. 해석 및 활용


# [ decision tree : 의사결정나무 ]
- 분류 모델 중 tree기반 모델의 기본이 되는 모델
- 모델 학습 시 각 설명변수마다 feature importace를 계산
  => 불순도 측정(각 변수로 인해 나뉘어진 자식노드의 각 class의 혼합도)
  => 단순한 트리를 생성하기 위해 불순도가 가장 낮은,
     feature importace가 가장 높은 설명변수를 상위 노드에 고정
     (만약 비슷한 불순도를 갖는 설명변수가 있다면
      더 많은 level을 갖는 변수가 우선순위를 갖는 특징을 가짐)

- 매개변수의 튜닝이 많이 필요하진 않지만 일반화 과정에서 필요하기도 함
1) cp 
 - 가지치기 변수로, 0~1의 값을 갖음
 - cptable을 통해 더 작은 size의 트리를 구성하기 위한 값을 확인
      cp   nsplit  size of tree(depth)   
    0.5      3         4
    0.15     4         5
    0.01     5         6
    
2) max_depth
 - 재사용 가능한 설명변수의 개수
 - 클수록 재사용 가능한 변수가 많아질 수 있음
   => 복잡한 트리의 생성 확률이 높아짐
   => 과대적합 확률도 높아짐
   
3) minsplit 또는 minbucket
   minbucket = round(minsplit/3)
  - 각 리프 노드마다 오분류 데이터의 수를 확인하여 더 split할지 여부를 
    결정하는 최소 분기 지점을 의미
    ex) minbucket 이 5로 설정된 경우 오분류 데이터가 5이상이면 추가 split
  - 값이 작을수록 트리는 복잡해짐
  
  
# [ decision tree in R - iris ]
1. train set과 test set 분리
 ** 원본 데이터가 각 class별로 균등하지 않은 경우는
    sampling한 데이터도 균등하지 않기 때문에 좋지 않음
    => 업샘플링, 다운샘플링을 통해 데이터를 균등하게 만들어 놓고
       train set과 test set으로 분리 필요
#
sn <- sample(nrow(iris), size = nrow(iris) * 0.7)
train <- iris[sn, ]
test <- iris[-sn, ]
table(train$Species)

2. train set을 적용, 모델 생성
library(rpart)
install.packages('party')
library(party)

ctree_model <- ctree(Species ~ ., 
                     data = train)

ctree_model  # 모델 확인
dev.new()
plot(ctree_model) # 모델 시각화

3. test set을 위 모델에 적용, score점수 확인
bool_v <- predict(ctree_model, newdata=test, 
                  type="response") # test셋의 모델을 통해 예측된 값 확인
test$Species # test set의 실제 정답
bool_v == test$Species # 예측값과 실제값이 같은지 확인
sum(bool_v == test$Species) # TRUE값만 sum 하므로 
                            # 예측과 실제값이 일치하는 개수 확인 가능
nrow(test) # 평가 데이터의 전체 건수
(score_1 <- sum(bool_v == test$Species) / nrow(test) * 100)

4. 매개변수 튜닝 및 고정
1) minbucket 변화에 따른 score 점수 확인
1-1) test set
score_v <- c()
for (i in 1:10) {
  m <- rpart(Species ~ . , 
             data=train,
             control = rpart.control(minbucket = i))
  val_var <- predict(m, newdata=test, type="class") 
  equal_v <- val_var == test$Species
  score_v <- c(score_v, sum(equal_v)/nrow(test) * 100)
}

score_v

1-2) train set
score_v2 <- c()

for (i in 1:10) {
  m <- rpart(Species ~ . , 
             data=train,
             control = rpart.control(minbucket = i))
  val_var <- predict(m, newdata=train, type="class") 
  equal_v <- val_var == train$Species
  score_v2 <- c(score_v2, sum(equal_v)/nrow(train) * 100)
}

5. 결과 해석

dev.new()
plot(1:10, score_v, type = 'b', 
     xlab = 'minbucket', col='red', ylim = c(95,100))
lines(1:10, score_v2, type = 'b')



# [ random forest ]
# [ random forest in R - cancer ]
cancer <- read.csv('cancer.csv')

1. train set과 test set 분리(upsampling 수행)
library(caret)
data <- upSample(cancer[ , -c(1,2)],  # 설명변수(X)
                 cancer[ , 2],        # 종속변수(Y)
                 yname = 'Class')     # 종속변수의 변경 후 컬럼이름

table(data$Class)  # class별로 균등하게 업샘플링 되었는지 확인

1) 원본 데이터 셋(불균형)에서 train/test 분리
rn <- sample(nrow(cancer), size = nrow(cancer)*0.7)
train <- cancer[rn, ]
test  <- cancer[-rn, ]

2) 업샘플링 데이터 셋(균형)에서 train/test 분리
library(doBy)
train_up <- sampleBy(~Class, data = data, frac = 0.7)

# train data set의 선택된 row number를 추출하기 위한 작업
f_split <- function(x) {
  as.numeric(strsplit(x,'\\.')[[1]][2])
}

rn2 <- sapply(rownames(train_up), f_split) # 벡터연산은 sapply로

# 위에서 선택된 train을 제외한 test data set 추출
test_up <- data[-rn2, ]

2. 모델 적용
library(randomForest)
m1 <- randomForest(diagnosis ~ . , data = train)
m2 <- randomForest(Class ~ . , data = train_up)

3. 모델 평가(upsampling data와의 비교)
3-1) m1 모델(불균형) 평가
v1 <- test$diagnosis ==  predict(m1, newdata = test, type = 'class')
sum(v1) / nrow(test) * 100

3-2) m2 모델(균형) 평가
v2 <- test_up$Class == predict(m2, newdata = test_up, type = 'class' )
sum(v2) / nrow(test_up) * 100

4. 매개변수 튜닝
1)ntree
score_v <- c()
v_i <- c()

for ( i in 1:1000 ) {
  m2 <- randomForest(Class ~ . , data = train_up, ntree = i)
  v2 <- test_up$Class == predict(m2, newdata = test_up, type = 'class' )
  v3 <- sum(v2) / nrow(test_up) * 100
  v_i <- c(v_i,i)
  score_v <- c(score_v, v3)
}

length(score_v)

2) mtry
# test data에 대한 score 확인
score_v2 <- c()

for ( i in 1:(length(colnames(train_up))-1)) {
  m2 <- randomForest(Class ~ . , data = train_up, mtry = i)
  v2 <- test_up$Class == predict(m2, newdata = test_up, type = 'class' )
  v3 <- sum(v2) / nrow(test_up) * 100
  score_v2 <- c(score_v2, v3)
}

# train data에 대한 score 확인
score_v3 <- c()

for ( i in 1:(length(colnames(train_up))-1)) {
  m2 <- randomForest(Class ~ . , data = train_up, mtry = i)
  v2 <- train_up$Class == predict(m2, newdata = train_up, type = 'class' )
  v3 <- sum(v2) / nrow(train_up) * 100
  score_v3 <- c(score_v3, v3)
}

5. 결과해석
1)ntree
dev.new()
plot(1:1000, score_v, type = 'b', xlab = 'size of tree')

2)mtry
plot(1:30, score_v2, type = 'b', col = 'red', 
                     xlab = 'mtry', ylim = c(96,100))
lines(1:30, score_v3, type = 'b', col = 'blue')

6. 예측
predict(m2, newdata = test_up, type = 'class' )







# [ random forest in R - cancer ]
cancer <- read.csv('cancer.csv')

1. train set과 test set 분리(upsampling 수행)
library(caret)
data <- upSample(cancer[ , -c(1,2)],  # 설명변수(X)
                 cancer[ , 2],        # 종속변수(Y)
                 yname = 'Class')     # 종속변수의 변경 후 컬럼이름

table(data$Class)  # class별로 균등하게 업샘플링 되었는지 확인

1) 원본 데이터 셋(불균형)에서 train/test 분리
rn <- sample(nrow(cancer), size = nrow(cancer)*0.7)
train <- cancer[rn, ]
test  <- cancer[-rn, ]

2) 업샘플링 데이터 셋(균형)에서 train/test 분리
library(doBy)
train_up <- sampleBy(~Class, data = data, frac = 0.7)

# train data set의 선택된 row number를 추출하기 위한 작업
f_split <- function(x) {
  as.numeric(strsplit(x,'\\.')[[1]][2])
}

rn2 <- sapply(rownames(train_up), f_split) # 벡터연산은 sapply로

# 위에서 선택된 train을 제외한 test data set 추출
test_up <- data[-rn2, ]

2. 모델 적용
m1 <- randomForest(diagnosis ~ . , data = train)
m2 <- randomForest(Class ~ . , data = train_up)

3. 모델 평가(upsampling data와의 비교)
3-1) m1 모델(불균형) 평가
v1 <- test$diagnosis ==  predict(m1, newdata = test, type = 'class')
sum(v1) / nrow(test) * 100

3-2) m2 모델(균형) 평가
v2 <- test_up$Class == predict(m2, newdata = test_up, type = 'class' )
sum(v2) / nrow(test_up) * 100


4. 매개변수 튜닝

5. 결과해석

6. 예측
predict(m2, newdata = test_up, type = 'class' )






