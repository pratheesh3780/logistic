attach(data)
diabetes<-as.factor(data$diabetes)
glm.fit <- glm(as.factor(diabetes) ~., data=data, family = binomial)
sum<-summary(glm.fit)
coeff<-as.data.frame(sum$coefficients)
View(coeff)
est<-coeff[,1]
oddsratio<-exp(est)
oddsratio[1]<-"NA"
