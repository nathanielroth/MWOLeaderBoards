# R script for calculating linear regressions on MWO leaderboard data
#     Copyright (C) 2016  Nathaniel Roth
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Load data and separate into distinct data frames
dfLB <- read.csv("LeaderBoards.csv")
dfFull <- dfLB
dfIS <- dfLB[dfLB$ISCL == 'IS',]
dfClan <- dfLB[dfLB$ISCL == 'Clan',]
dfLight <- dfLB[dfLB$Class == 'Light',]
dfMedium <- dfLB[dfLB$Class == 'Medium',]
dfAssault <- dfLB[dfLB$Class == 'Assault',]

# full DS Analysis
# Linear model for IS Vs Clans  and tonage
lmF_ISCL_Tons  <- lm(Score ~ ISCL + Tons, dfFull)
summary(lmF_ISCL_Tons)


# Linear mode based on tons only
lmF_Tons <- lm(Score ~ Tons, dfFull)
summary(lmF_Tons)

# Plot the tonnage with the prediction
plot(dfFull$Tons, dfFull$Score, main=" Score by Tons", xlab="Tons", ylab="Score")
abline(lm(dfFull$Score~dfFull$Tons))

# Linear model of clan vs IS (just because)
lmf_ISCL <- lm(Score ~ ISCL, dfFull)
summary(lmf_ISCL)

# AOV on IS vs Clan and Tons to identify whether differences are real. 
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



# predit Full with IS vs Clan and tons
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


# predit Full with tons
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
write.csv(dfResults_Tons, file="results_full_tons_wCyclops.csv")

# predit Full with tons
dfFull_Tons_log <- dfFull
dfFull_Tons_log$lScore <- log(dfFull_Tons_log$Score)
dfFull_Tons_log$lTons <- log(dfFull_Tons_log$Tons)
lmF_logTons <- lm(lScore ~ lTons, dfFull_Tons_log)
summary(lmF_logTons)
dfFull_Tons_log$predAll <- predict(lmF_logTons)
dfFull_Tons_log$residAll <- dfFull_Tons_log$lScore - dfFull_Tons_log$predAll
mech_mean_Tons <- aggregate(. ~ Mech, dfFull_Tons_log, function(lScore) c(mean = mean(lScore)))
resid_mean_Tons <- aggregate(. ~ Mech, dfFull_Tons_log, function(residAll) c(mean = mean(residAll)))
resid_median_Tons <- aggregate(. ~ Mech, dfFull_Tons_log, function(residAll) c(median = median(residAll)))
dfResults_Tons <- mech_mean_Tons[,c("Mech","lScore")]
dfResults_Tons$pred <- resid_mean_Tons$predAll
dfResults_Tons$mean_resid <- resid_mean_Tons$residAll
dfResults_Tons$median_resid <- resid_median_Tons$residAll
write.csv(dfResults_Tons, file="results_full_tons_ll_wCyclops.csv")

