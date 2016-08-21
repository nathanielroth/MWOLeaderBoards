# MWOLeaderBoards

Statistical analysis of Mechwarrior Online leaderboard data. All data from mwomercs.com

I did this because I was both bored and frustrated with the continual sniping about which is better and balance in the game. Lots of annecdotal evidence on both sides, but surprisingly little real analysis. A small portion of this work was informed by a spreadsheet prepared (I'm told) by Tarogato from ISEN. I recompiled the data on my own, though I reused his approach for integrating data for the Viper.

I shouldn't be too hard to find. I pilot in MWO under the name of Tahawus with the unit C4. And my contact info is associated with this gitub account.

All results and any opinions are my work only. Please provide credit should you choose to build on my work. 

Some notes and thoughts:

The distributions of scores are non-normal and do not transform easily, so all of these results should be interpreted with caution. i.e. I belive the conclusions we can draw are valid, but if you're going to base an active handicapping system or online gambling odds on these you're on your own (unless the latter proves profitable, in which case I want royalties). 

I'm making a number of other assumptions here that should be stated.
1. The top 75 results for each mech are representative of high performing pilots in that mech and that the pilot quality is even between mechs. i.e. we don't have a major effect in which mech rankings are influenced by better pilots choosing to pilot better mechs leaving poorer pilots to dominate the lower performing mechs. 
2. That the scoring system is a good representation of the utility of the mech. 
3. The non-normality of the data isn't a critical failure
4. A linear model is appropriate (It generally tests well and has reasonable distributions of residuals for the model), but given the non-normality is subject to being questioned.

