# R script for evaluating the leader board from the Weight of the World Event (8/19/2016-8/23/2016)
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
library(gdata)
library(reshape2)


dfLB <- read.csv("WeightOfTheWorld.csv")
dfMechs <- read.csv("Mechs.csv")
dfFull <- merge(x=dfLB,y = dfMechs, by = "Mech",all = TRUE)
dfNoScore <- dfFull[is.na(dfFull$Score),] # List of mechs that don't appear in the leaderboard
dfScore <- na.omit(dfFull) #Joined datatable with mech weight, class, and score
dfScore <- drop.levels(dfScore)

dfLight <- drop.levels(dfScore[dfScore$Class == 'Light',])
dfMedium <- drop.levels(dfScore[dfScore$Class == 'Medium',])
dfHeavy <- drop.levels(dfScore[dfScore$Class == 'Heavy',])
dfAssault <- drop.levels(dfScore[dfScore$Class == 'Assault',])

par(mar=c(10,4,4,4))




# IS Vs Clan
counts <- table(dfScore$ISCL,dfScore$Mech)
barplot(counts, las = 3 )

t(table(dfScore$Class,dfScore$Mech))

# Light

t(table(dfLight$Mech))
table(dfLight$ISCL)
counts <- table(dfLight$ISCL,dfLight$Mech)
barplot(counts, main = "Light", legend = rownames(counts), las = 3 )


# Medium
t(table(dfMedium$Mech))
table(dfMedium$ISCL)
counts <- table(dfMedium$ISCL,dfMedium$Mech)
barplot(counts, main = "Medium", legend = rownames(counts), las = 3 )


# Heavy
t(table(dfHeavy$Mech))
table(dfHeavy$ISCL)
counts <- table(dfHeavy$ISCL,dfHeavy$Mech)
barplot(counts, main = "Heavy", legend = rownames(counts), las = 3 )

aggregate(dfHeavy, by=list(dfHeavy$ISCL), FUN=mean)
aggregate(dfHeavy$Place, by=list(dfHeavy$ISCL), FUN=median)


# Assault
t(table(dfAssault$Mech))
table(dfAssault$ISCL)
counts <- table(dfAssault$ISCL,dfAssault$Mech)
barplot(counts, main = "Assault", legend = rownames(counts), las = 3 )