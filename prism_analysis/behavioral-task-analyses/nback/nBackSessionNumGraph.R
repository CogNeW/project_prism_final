library(dplyr)
library(ggplot2)

nBack_exp = read.csv(file = 'n-back_exp_results.csv')

nBack_exp$n_back <- as.factor(nBack_exp$n_back)
nBack_exp$trialN <- as.factor(nBack_exp$trialN)
nBack_exp$counterbalance <- as.factor(nBack_exp$counterbalance)
nBack_exp$sessionNum <- as.numeric(nBack_exp$sessionNum)
nBack_exp$timepoint <- as.factor(nBack_exp$timepoint)
nBack_exp$stim_site <- as.factor(nBack_exp$stim_site)


#changing reference level of timepoint to pre to make interpretation of models easier
nBack_exp$timepoint <- relevel(nBack_exp$timepoint, ref = 'pre')
nBack_exp$stim_site <-relevel(nBack_exp$stim_site, ref = 'vertex')
#keeping only ``n-back`` trials for analysis
nBack_exp_filter <- nBack_exp %>% filter(trialType == 1)


nBack_exp_filterPre <- nBack_exp_filter %>% filter(timepoint == 'pre') %>% group_by(subject, n_back, sessionNum) %>% summarize(meanAcc = mean(correct), stdAcc = sd(correct))

ggplot(nBack_exp_filterPre, aes(sessionNum, meanAcc)) +
  geom_point() + 
  geom_smooth(method = 'lm', se = FALSE) +
  theme_classic() +
  xlab(label = 'Session #') + 
  ylab(label = 'Mean Accuracy') +
  labs(title = 'Mean Accuracy for Subjects Across Sessions\n by n-Back Load') +
  theme(plot.title = element_text(hjust = .5), plot.subtitle = element_text(hjust = .5),
        strip.background = element_blank()) +
  facet_grid(n_back ~ subject)


ggplot(nBack_exp_filterPre, aes(sessionNum, meanAcc)) +
  geom_point() +
  geom_point(aes(x = sessionNum, y = meanAcc - stdAcc), color = 'red') +
  geom_point(aes(x = sessionNum, y = meanAcc + stdAcc), color = 'blue') +
  geom_smooth(method = 'lm', se = FALSE) +
  theme_classic() +
  xlab(label = 'Session #') + 
  ylab(label = 'Mean Accuracy') +
  labs(title = 'Mean Accuracy for Subjects Across Sessions\n by n-Back Load') +
  theme(plot.title = element_text(hjust = .5), plot.subtitle = element_text(hjust = .5),
        strip.background = element_blank()) +
  facet_grid(n_back ~ subject)