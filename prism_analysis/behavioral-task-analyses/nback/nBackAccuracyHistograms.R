library(lme4)
library(dplyr)
library(emmeans)
library(ggplot2)
library(car)

nBack_exp = read.csv(file.choose())

nBack_exp$n_back <- as.factor(nBack_exp$n_back)
nBack_exp$trialN <- as.factor(nBack_exp$trialN)
nBack_exp$counterbalance <- as.factor(nBack_exp$counterbalance)
nBack_exp$sessionNum <- as.factor(nBack_exp$sessionNum)
nBack_exp$session <- as.factor(nBack_exp$session)
nBack_exp$stim_site <- as.factor(nBack_exp$stim_site)

nBack_exp_0Back <- nBack_exp %>% filter(session == 'pre', trialType == 1, n_back == 0)

nBack_exp_0BackAccSummary <- nBack_exp_0Back %>% group_by (subject, sessionNum) %>% summarize(meanAcc = mean(correct), stdAcc = sd(correct))

hist(nBack_exp_0BackAccSummary$meanAcc, breaks=20, main="0-back Accuracy by Subject and Session Number",
    col="blue", xlim=c(0.4,1), ylim=c(0,25), xlab="Mean Accuracy");

nBack_exp_1Back <- nBack_exp %>% filter(session == 'pre', trialType == 1, n_back == 1)

nBack_exp_1BackAccSummary <- nBack_exp_1Back %>% group_by (subject, sessionNum) %>% summarize(meanAcc = mean(correct), stdAcc = sd(correct))

hist(nBack_exp_1BackAccSummary$meanAcc, breaks=10, main="1-back Accuracy by Subject and Session Number",
     col="blue", xlim=c(0.4,1), ylim=c(0,15), xlab="Mean Accuracy");

nBack_exp_2Back <- nBack_exp %>% filter(session == 'pre', trialType == 1, n_back == 2)

nBack_exp_2BackAccSummary <- nBack_exp_2Back %>% group_by (subject, sessionNum) %>% summarize(meanAcc = mean(correct), stdAcc = sd(correct))

hist(nBack_exp_2BackAccSummary$meanAcc, breaks=20, main="2-back Accuracy by Subject and Session Number",
     col="blue", xlim=c(0.4,1), ylim=c(0,15), xlab="Mean Accuracy");

# reaction time histograms
nBack_exp_RT = read.csv(file.choose())

nBack_exp_0BackCorr <- nBack_exp_RT %>% filter(session == 'pre', trialType == 1, n_back == 0, correct == 1)
nBack_exp_0BackRTSummary <- nBack_exp_0BackCorr %>% group_by (subject, sessionNum) %>% summarize(medianRT = median(rt), stdRT = sd(rt))

hist(nBack_exp_0BackRTSummary$medianRT, breaks=15, main="0-back Median RT by Subject and Session Number",
     col="blue", xlim=c(0.2,0.7), ylim=c(0,8), xlab="Median RT");

nBack_exp_1BackCorr <- nBack_exp_RT %>% filter(session == 'pre', trialType == 1, n_back == 1, correct == 1)
nBack_exp_1BackRTSummary <- nBack_exp_1BackCorr %>% group_by (subject, sessionNum) %>% summarize(medianRT = median(rt), stdRT = sd(rt)) 

hist(nBack_exp_1BackRTSummary$medianRT, breaks=10, main="1-back Median RT by Subject and Session Number",
     col="blue", xlim=c(0,1), ylim=c(0,15), xlab="Median RT");

nBack_exp_2BackCorr <- nBack_exp_RT %>% filter(session == 'pre', trialType == 1, n_back == 2, correct == 1)
nBack_exp_2BackRTSummary <- nBack_exp_2BackCorr %>% group_by (subject, sessionNum) %>% summarize(medianRT = median(rt), stdRT = sd(rt)) 

hist(nBack_exp_2BackRTSummary$medianRT, breaks=15, main="2-back Median RT by Subject and Session Number",
     col="blue", xlim=c(0,1), ylim=c(0,15), xlab="Median RT");


nBack0Actual <- hist((nBack_exp_0BackAccSummary$meanAcc*100), main="0-back Accuracy by Subject and Session Number", col="blue", xlim=c(0,100), xlab="Mean Accuracy");
nBack0Norm <- hist(normNBackData$WM_Task_0bk_Acc, main="0-back Accuracy across Subjects")
plot(nBack0Norm, col=rgb(0,0,1,1/4), xlim=c(0,100))
plot(nBack0Actual, col=rgb(1,0,0,1/4), xlim=c(0,100), add=T)

nBack0Actual <- hist((nBack_exp_0BackAccSummary$meanAcc*100), main="0-back Accuracy by Subject and Session Number", col="blue", xlim=c(0,100), xlab="Mean Accuracy");
nback0Norm <- hist(normNBackData$WM_Task_0bk_Acc, main="0-back Accuracy across Subjects")
plot(nback0Norm, col=rgb(0,0,1,1/4), xlim=c(0,100))
plot(nBack0Actual, col=rgb(1,0,0,1/4), xlim=c(0,100), add=T)

