dfLB <- read.csv("LeaderBoards.csv")
dfFull <- dfLB
dfIS <- dfLB[dfLB$ISCL == 'IS',]
dfClan <- dfLB[dfLB$ISCL == 'Clan',]
dfLight <- dfLB[dfLB$Class == 'Light',]
dfMedium <- dfLB[dfLB$Class == 'Medium',]
dfAssault <- dfLB[dfLB$Class == 'Assault',]

# full DS

lmF_ISCL_Tons  <- lm(Score ~ ISCL + Tons, dfFull)
summary(lmF_ISCL_Tons)

lmF_Tons <- lm(Score ~ Tons, dfFull)
summary(lmF_Tons)
plot(dfFull$Tons, dfFull$Score, main=" Score by Tons", xlab="Tons", ylab="Score")
abline(lm(dfFull$Score~dfFull$Tons))

lmf_ISCL <- lm(Score ~ ISCL, dfFull)
summary(lmf_ISCL)

fit_ISCL_Tons <- aov(Score ~ ISCL*Tons, data=dfFull)
summary(fit_ISCL_Tons)

# IS only
lmIS <- lm(Score ~ Tons, dfIS)
summary(lmIS)
plot(dfIS$Tons, dfIS$Score, main="IS: Score by Tons", xlab="Tons", ylab="Score")
abline(lm(dfIS$Score~dfIS$Tons))


# Clan only
lmClan <- lm(Score ~ Tons, dfClan)
summary(lmClan)
plot(dfClan$Tons, dfClan$Score, main="Clans: Score by Tons", xlab="Tons", ylab="Score")
abline(lm(dfClan$Score~dfClan$Tons))



# predit Full with IS vs Clan
dfFull_ISCL_Tons <- dfFull
dfFull_ISCL_Tons$predAll <- predict(lmF_ISCL_Tons)
dfFull_ISCL_Tons$residAll <- dfFull_ISCL_Tons$Score - dfFull_ISCL_Tons$predAll
mech_mean_ISCL_Tons <- aggregate(. ~ Mech, dfFull_ISCL_Tons, function(Score) c(mean = mean(Score)))
resid_mean_ISCL_Tons <- aggregate(. ~ Mech, dfFull_ISCL_Tons, function(residAll) c(mean = mean(residAll)))
resid_median_ISCL_Tons <- aggregate(. ~ Mech, dfFull_ISCL_Tons, function(residAll) c(median = median(residAll)))
dfResults_ISCL_Tons <- mech_mean_ISCL_Tons[,c("Mech","Score")]
dfResults_ISCL_Tons$pred <- resid_mean_ISCL_Tons$predAll
dfResults_ISCL_Tons$mean_resid <- resid_mean_ISCL_Tons$residAll
dfResults_ISCL_Tons$median_resid <- resid_median_ISCL_Tons$residAll
write.csv(dfResults_ISCL_Tons, file="results_full_ISCL_Tons.csv")


# predit Full with IS vs Clan
dfFull_Tons <- dfFull
dfFull_Tons$predAll <- predict(lmF_Tons)
dfFull_Tons$residAll <- dfFull_Tons$Score - dfFull_Tons$predAll
mech_mean_Tons <- aggregate(. ~ Mech, dfFull_Tons, function(Score) c(mean = mean(Score)))
resid_mean_Tons <- aggregate(. ~ Mech, dfFull_Tons, function(residAll) c(mean = mean(residAll)))
resid_median_Tons <- aggregate(. ~ Mech, dfFull_Tons, function(residAll) c(median = median(residAll)))
dfResults_Tons <- mech_mean_Tons[,c("Mech","Score")]
dfResults_Tons$pred <- resid_mean_Tons$predAll
dfResults_Tons$mean_resid <- resid_mean_Tons$residAll
dfResults_Tons$median_resid <- resid_median_Tons$residAll
write.csv(dfResults_Tons, file="results_full_tons.csv")








#########################################
# # normality
# dfLocust <- dfLB[dfLB$Mech == 'Locust',]
# hist(dfLocust$Score)
# shapiro.test(dfLocust$Score)

