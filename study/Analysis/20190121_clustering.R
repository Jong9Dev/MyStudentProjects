# [군집분석]
- y가 없는 데이터(설명변수만 존재)의 클러스터링
- 거리 기반 모델로 거리가 가까운 관측치들은 비슷한 특징을 가질것이라는 
  전제하에 클러스터링을 기반으로 데이터 축소(군집화)
- 계층적 VS 비계층적 구분 : 순차적 그룹 할당 여부에 따라
- 최단, 최장, 평균, 메디안 : 클러스터와 개별 관측치의 거리 계산 기준에 따라

# 계층적 군집분석 과정(평균)
v1 <- c(1,3,6,10,18)
(d1 <- dist(v1))
   1  2  3  4
2  2         
3  5  3      
4  9  7  4   
5 17 15 12  8

step1) 각 개별 관측치의 거리를 계산, 
       가장 가까운 두 관측치를 묶어 클러스터 생성 => C1(O1, O2)

step2) 새로 생긴 C1과 개별 관측치와의 거리 계산
   C1 3  4
3  4        
4  8  4   
5  16 12 8

d(C1,O3) = d(O1,O3)와 d(O2,O3)의 평균 = avg(5,3) = 4
d(C1,O4) = d(O1,O4)와 d(O2,O4)의 평균 = avg(9,7) = 8
d(C1,O5) = d(O1,O5)와 d(O2,O5)의 평균 = avg(17,15) = 16

step3) 위에서 구한 클러스터와 관측치의 거리를 모두 고려, 
       가장 거리가 짧은 관측치를 C1에 포함시키거나 새로운 클러스터 생성
       거리가 같을 경우는 클러스터 소속 우선순위이므로 3번째 관측치가
       C1에 포함  => C1(O1,O2,O3)
       
STEP4) 새로 생기거나 갱신된 클러스터와 개별 관측치와의 거리 계산
   C1   4
4 6.7    
5 14.7  8

d(C1,O4) = d(O1,O4), d(O2,O4), d(O3,O4)의 평균 = avg(9,7,4) = 6.67
d(C1,O5) = d(O1,O5), d(O2,O5), d(O3,O5)의 평균 = avg(17, 15, 12) = 14.67

step5) 반복적으로 각 거리 계산, 가장 짧은 거리 포함 혹은 새 클러스터 생성
       => C1(O1,O2,O3,O4)

# 군집 분석 수행 및 시각화
# 1. 거리행렬 구하기
(d1 <- dist(v1))

# 2. 거리행렬 모델 적용
m1 <- hclust(d1, method = 'average')

** method : 클러스터와 관측치와의 거리 계산 기준
- single : 최단거리법, 단일기준법
- complete : 최장거리법, 완전기준법
- average : 평균기준법
- median : 중앙중심법

3. 시각화(벤다이어그램)
plot(m1, hang = -10)
rect.hclust(m1, k=2)














