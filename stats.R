distance_data <- read_csv("distance_data_for_R.csv")
cue_data <- read_csv("cue_data_for_R.csv")
response_data <- read_csv("response_data_for_R.csv")
rt_data <- read_csv("baseline_rt.csv")

distance_data$Time <- mapvalues(distance_data$Time, to=c("T0", "T50", "T100", "T150", "T200", "T250", "T300"), from=c(0, 50, 100, 150, 200, 250, 300))
cue_data$Time <- mapvalues(cue_data$Time, to=c("T0", "T50", "T100", "T150", "T200", "T250", "T300"), from=c(0, 50, 100, 150, 200, 250, 300))

euclidean_cue_data = (filter(distance_data, Analysis == 'Cue', Group == 'Euclidean'))
cosine_cue_data = (filter(distance_data, Analysis == 'Cue', Group == 'Cosine'))
euclidean_response_data = (filter(distance_data, Analysis == 'Response', Group == 'Euclidean'))
cosine_response_data = (filter(distance_data, Analysis == 'Response', Group == 'Cosine'))

cue_data$MEP <- log(cue_data$MEP)
a <- lmer(MEP ~ Group + Coil + Time + Group*Coil + Group*Time + Coil*Time + Group*Coil*Time + (1|Subject), data = cue_data)

qqnorm(resid(a))
qqline(resid(a))

summary(a)
anova(a)
emmeans(a, pairwise ~ Group*Time)
table <- as.data.frame(emmeans(a, pairwise ~ Group*Time)$contrasts)
table2 <- xtable(emmeans(a, pairwise ~ Group*Time)$contrasts)

write.table((emmeans(a, pairwise ~ Coil)$contrasts), "cue_locked_mep_coil.txt", sep="\t")
write.table((emmeans(a, pairwise ~ Group)$contrasts), "cue_locked_mep_task.txt", sep="\t")
write.table((emmeans(a, pairwise ~ Time)$contrasts), "cue_locked_mep_time.txt", sep="\t")
write.table((emmeans(a, pairwise ~ Group*Time)$contrasts), "cue_locked_mep_task*time.txt", sep="\t")

response_data$MEP <- log(response_data$MEP)
b <- lmer(MEP ~ Group + Coil + Time + Group*Coil + Group*Time + Coil*Time + Group*Coil*Time + (1|Subject), data = response_data)

qqnorm(resid(b))
qqline(resid(b))

summary(b)
anova(b)
emmeans(b, pairwise ~ Group*Coil)
table <- as.data.frame(emmeans(b, pairwise ~ Group*Time)$contrasts)
table2 <- xtable(emmeans(b, pairwise ~ Group*Time)$contrasts)

euclidean_cue_data$Distance <- log(euclidean_cue_data$Distance)
c <- lmer(Distance ~ Type + Time + Type*Time + (1|Subject), data = euclidean_cue_data)

qqnorm(resid(c))
qqline(resid(c))

summary(c)
anova(c)
emmeans(c, pairwise ~ Type*Time)

write.table((emmeans(c, pairwise ~ Time)$contrasts), "cue_locked_euclidean_time.txt", sep="\t")
write.table((emmeans(c, pairwise ~ Type)$contrasts), "cue_locked_euclidean_analysis.txt", sep="\t")

cosine_cue_data$Distance <- log(cosine_cue_data$Distance)
d <- lmer(Distance ~ Type + Time + Type*Time + (1|Subject), data = cosine_cue_data)

qqnorm(resid(d))
qqline(resid(d))

summary(d)
anova(d)
emmeans(d, pairwise ~ Type)

write.table((emmeans(d, pairwise ~ Type)$contrasts), "cue_locked_cosine_analysis.txt", sep="\t")

euclidean_response_data$Distance <- log(euclidean_response_data$Distance)
e <- lmer(Distance ~ Type + Time + Type*Time + (1|Subject), data = euclidean_response_data)

qqnorm(resid(e))
qqline(resid(e))

summary(e)
anova(e)
emmeans(e, pairwise ~ Type*Time)

write.table((emmeans(e, pairwise ~ Time)$contrasts), "response_locked_euclidean_time.txt", sep="\t")
write.table((emmeans(e, pairwise ~ Type)$contrasts), "response_locked_euclidean_analysis.txt", sep="\t")

cosine_response_data$Distance <- log(cosine_response_data$Distance)
f <- lmer(Distance ~ Type + Time + Type*Time + (1|Subject), data = cosine_response_data)

qqnorm(resid(f))
qqline(resid(f))

summary(f)
anova(f)
emmeans(f, pairwise ~ Type*Time)

write.table((emmeans(f, pairwise ~ Type)$contrasts), "response_locked_cosine_analysis.txt", sep="\t")


g <- lmer(RT ~ Coil + Task + Coil*Task + (1|Subject), data = rt_data)

qqnorm(resid(g))
qqline(resid(g))

summary(g)
anova(g)
emmeans(g, pairwise ~ Coil*Task)

