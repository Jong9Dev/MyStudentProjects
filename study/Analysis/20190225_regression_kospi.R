k_index <- read.csv("K_index.csv" , header = T , stringsAsFactors = F)
s_stock <- read.csv("S_stock.csv" , header = T , stringsAsFactors = F)
h_stock <- read.csv("H_stock.csv" , header = T , stringsAsFactors = F)
all_data <- merge(merge(k_index , s_stock) , h_stock) 
head(all_data)
str(all_data) 


plot(all_data$k_rate , all_data$s_rate) 

s_lm <- lm(s_rate ~ k_rate , data = all_data) 
h_lm <- lm(h_rate ~ k_rate , data = all_data) 

summary(s_lm) 
summary(h_lm) 

