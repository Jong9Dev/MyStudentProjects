data.table 
DB���� table������ Ư�� �÷��� �ַΰ��� ���� index�� �����Ͽ�
key�� ���� ���� �� �˻��� ������ ������ �� �ִ� ���� ������ ����
������ ���� ���� ����
- key�� ���� ���� �˻�(����)
- key�� ���� �׷� ����
- key�� ���� ����

1. table ����
iris_big <- c()
for ( i in 1:1000 ) {
  iris_big <- rbind(iris_big, iris)
}
nrow(iris_big)

2. key ����
library(data.table)
iris_big_table <- as.data.table(iris_big)
setkey(iris_big_table, Species)  # Species�� ���� �ּҸ� ���� index ����

3. �ӵ� �׽�Ʈ
3-1) iris_big�� ���� ��� ����(data frame����)
library(plyr)

system.time(a<-1)
system.time(ddply(iris_big, .(Species), summarise, m1 = mean(Sepal.Length),
                                                   m2 = mean(Sepal.Width)))

3-2) iris_big_table�� ���� ��� ����(table����)
system.time(ddply(iris_big_table, .(Species), summarise, 
                  m1 = mean(Sepal.Length),
                  m2 = mean(Sepal.Width)))









