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

library(gdata)


# Load data and separate into distinct data frames
dfLB <- read.csv("LeaderBoards.csv")
dfFull <- dfLB
dfIS <- dfLB[dfLB$ISCL == 'IS',]
dfClan <- dfLB[dfLB$ISCL == 'Clan',]
dfLight <- dfLB[dfLB$Class == 'Light',]
dfMedium <- dfLB[dfLB$Class == 'Medium',]
dfAssault <- dfLB[dfLB$Class == 'Assault',]

opar <-par()
par(las=3)
par(mar=c(8,4,4,4))

dfAssault <- drop.levels(dfAssault)
boxplot(Score~Mech, data=dfAssault, main="Score by Mech", las=3)


