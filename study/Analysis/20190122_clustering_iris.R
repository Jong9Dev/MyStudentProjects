# clustering in R - iris data
# 1. 계층적 군집분석
# 1) 평균기준법

# step1) scale 조정
scaled_iris <- scale(iris[,-5])

# step2) 거리행렬 구하기
dist_iris <- dist(scaled_iris)

# step3) clustering 모델 생성
cluster_iris <- hclust(dist_iris, method = 'average')
cutree_iris <- cutree(cluster_iris, k=3)

# step4) cluster 시각화 및 확인
cutree_iris # 각 관측치마다 분류되는 cluster의 번호 확인 가능
table(cutree_iris)

# cross table 확인(각 cluster의 포함 관측치 수)
cutree_iris
 1  2  3 
50 97  3

cutree_iris2
table(cutree_iris2)

dev.new()
plot(cluster_iris, hang = -1, cex =0.7)
rect.hclust(cluster_iris, k=3)

plot(cluster_iris2, hang = -1, cex =0.7)
rect.hclust(cluster_iris2, k=3)

# ** 모델 비교를 위한 함수 생성 
f_cluster <- function(data,y,k=3,method='average') {
  dist_iris <- dist(data)
  cluster_iris <- hclust(dist_iris, method = method)
  cutree_iris <- cutree(cluster_iris, k=k)
  v1 <- cutree_iris == as.numeric(y) 
  return(sum(v1) / nrow(data) * 100)
}

f_cluster(iris[,-5],iris$Species) # 90
f_cluster(scale(iris[,-5]),iris$Species) # 68.67

f_cluster(iris[,c(3,4)],iris$Species) # 96
f_cluster(scale(iris[,c(3,4)]),iris$Species) # 98

# 2) 최단거리기준법
f_cluster(iris[,-5],iris$Species,method = 'single') # 68

# 3) 최장거리기준법
f_cluster(iris[,-5],iris$Species,method = 'complete') # 49

# 2. 비 계층적 군집분석(k-means)
(kms <- kmeans(scale(iris[,c(3,4)]) , 3))

v1 <- kms$cluster == as.numeric(iris$Species)
sum(v1) / nrow(iris) * 100

# 군집 평가
round(kms$betweenss / kms$totss * 100,1)

# elbow point를 확인하여 적절한 K수 모색
bet_ss <- c()
for (i in 1:10) {
  kms <- kmeans(scale(iris[,c(3,4)]) , i)
  bet_ss[i] <- round(kms$betweenss / kms$totss * 100,1)
}

y_name = paste("between_ss","\n", "/", "\n", "total_ss", collapse = '')

dev.new()
par(oma=c(0,5,0,0)) # 그래프 여백 조절(하,좌,상,우)
par(mgp=c(1,0.1,0))   # 그래프 내 축 여백 조절(제목, 눈금, 지표선)
plot(1:10, bet_ss, type="b", 
     xlab = "Number of Clusters", 
     ylab = y_name, ann = F, axes = F)

axis(1, at = 1:10, las = 1)












