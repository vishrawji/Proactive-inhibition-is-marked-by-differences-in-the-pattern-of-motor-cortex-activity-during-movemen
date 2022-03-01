setwd("/Users/Vish 1/Documents/Characterising the nature of proactive and reactive inhibitio - a TMS study/Simple Stop Signal Task/Result")

#install.packages("tidyverse")
#install.packages("lme4")
#install.packages("emmeans")

library(tidyverse)
library(gridExtra)
library(grid)
library(pathwork)
library(ggpubr)
library(lme4)
library(nlme)
library(lmerTest)
library(emmeans)

distance_data <- read_csv("distance_data_for_R.csv")
cue_data <- read_csv("cue_data_for_R.csv")
response_data <- read_csv("response_data_for_R.csv")


cue_summary <- summarySE(cue_data, measurevar="MEP", groupvars=c("Group","Coil","Time"))
response_summary <- summarySE(response_data, measurevar="MEP", groupvars=c("Group","Coil","Time"))

tick_text_size <- 10
axis_text_size <- 12
line_size = 0.75
point_size = 2
errorbar_size = 1

response_labels <- c("50-100", "100-150", "150-200", "200-250", "250-300", "300-350")

pa_cue_plot <-  ggplot(subset(cue_summary, Coil=='PA'), aes(x=Time, y=MEP, colour=Group)) + 
  geom_errorbar(aes(ymin=MEP-se, ymax=MEP+se), width=0.1, size = errorbar_size) +
  geom_line(aes(linetype=Group), size=line_size) +
  geom_point() +
  scale_linetype_manual(values=c(1, 2)) +
  scale_color_manual(values=c("blue", "red")) +
  geom_hline(aes(yintercept = 1), linetype = "dashed", size = line_size) +
  ylim(0.5,4.5) +
  xlab("Time from cue (ms)") +
  ylab("") +
  ggtitle("PA") +
  theme(plot.title = element_text(hjust = 0.5, size = axis_text_size, face = "bold")) +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")


ap_cue_plot <-  ggplot(subset(cue_summary, Coil=='AP'), aes(x=Time, y=MEP, colour=Group)) + 
  geom_errorbar(aes(ymin=MEP-se, ymax=MEP+se), width=0.1, size = errorbar_size) +
  geom_line(aes(linetype=Group), size=line_size) +
  geom_point() +
  scale_linetype_manual(values=c(1, 2)) +
  scale_color_manual(values=c("blue", "red")) +
  geom_hline(aes(yintercept = 1), linetype = "dashed", size = line_size) +
  ylim(0.5,4.5) +
  xlab("Time from cue (ms)") +
  ylab("") +
  ggtitle("AP") +
  theme(plot.title = element_text(hjust = 0.5, size = axis_text_size, face = "bold")) +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")


pa_response_plot <-  ggplot(subset(response_summary, Coil=='PA'), aes(x=Time, y=MEP, colour=Group)) + 
  geom_errorbar(aes(ymin=MEP-se, ymax=MEP+se), width=0.1, size = errorbar_size) +
  geom_line(aes(linetype=Group), size=line_size) +
  geom_point() +
  scale_linetype_manual(values=c(1, 2)) +
  scale_color_manual(values=c("blue", "red")) +
  xlab("Time from response (ms)") +
  ylab("") +
  scale_x_reverse(
    limits = c(300, 50), 
    breaks = seq(300, 50, by = -50),
    labels = rev(response_labels)
  ) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 7), breaks = c(0, 1, 2, 3, 4, 5, 6, 7)
                     , labels = c(0, 1, 2, 3, 4, 5, 6, 7)) +
  theme(plot.title = element_text(hjust = 0.5, size = axis_text_size, face = "bold")) +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")

ap_response_plot <-  ggplot(subset(response_summary, Coil=='AP'), aes(x=Time, y=MEP, colour=Group)) + 
  geom_errorbar(aes(ymin=MEP-se, ymax=MEP+se), width=0.1, size = errorbar_size) +
  geom_line(aes(linetype=Group), size=line_size) +
  geom_point() +
  scale_linetype_manual(values=c(1, 2)) +
  scale_color_manual(values=c("blue", "red")) +
  xlab("Time from response (ms)") +
  ylab("") +
  scale_x_reverse(
    limits = c(300, 50), 
    breaks = seq(300, 50, by = -50),
    labels = rev(response_labels)
  ) +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 7), breaks = c(0, 1, 2, 3, 4, 5, 6, 7)
                     , labels = c(0, 1, 2, 3, 4, 5, 6, 7)) +
  theme(plot.title = element_text(hjust = 0.5, size = axis_text_size, face = "bold")) +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")

combined_figure_1 <- ggarrange(pa_cue_plot, ap_cue_plot, pa_response_plot, ap_response_plot, labels = c("A", "B", "C", "D"), common.legend = TRUE, legend="bottom", ncol = 2, nrow = 2)
annotate_figure(combined_figure_1,
                left = text_grob("Normalised MEP amplitude", rot = 90, face="bold", size = axis_text_size),
)

pa_cue_go_only = (filter(cue_summary, Group == 'Go-only', Coil == 'PA'))$MEP
ap_cue_go_only = (filter(cue_summary, Group == 'Go-only', Coil == 'AP'))$MEP
pa_cue_sst = (filter(cue_summary, Group == 'SST', Coil == 'PA'))$MEP
ap_cue_sst = (filter(cue_summary, Group == 'SST', Coil == 'AP'))$MEP

cue_meps = tibble(pa_cue_go_only, ap_cue_go_only, pa_cue_sst, ap_cue_sst)

lds_cue <-  ggplot(cue_meps, aes(x=pa_cue_go_only, y=ap_cue_go_only)) +
  geom_path(color = "blue", size=line_size) +
  geom_point(color = "blue", size = point_size) +
  geom_point(cue_meps, mapping = aes(x=pa_cue_go_only[1], y=ap_cue_go_only[1]), color = "blue", shape = 8, size = point_size+2) +
  geom_path(cue_meps, mapping = aes(x=pa_cue_sst, y=ap_cue_sst), color = "red", size=line_size) +
  geom_point(cue_meps, mapping = aes(x=pa_cue_sst, y=ap_cue_sst), color = "red", size = point_size) +
  geom_point(cue_meps, mapping = aes(x=pa_cue_sst[1], y=ap_cue_sst[1]), color = "red", shape = 8, size = point_size+2) +
  geom_abline(slope=1, intercept = 0, linetype = "dashed", size = line_size) +
  xlab("Normalised \n PA MEP amplitude") +
  ylab("Normalised \n AP MEP amplitude") +
  xlim(0,4) +
  ylim(0,3) +
  ggtitle("Cue-locked") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", colour = "black", size = axis_text_size+5)) +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")
lds_cue

pa_response_go_only = (filter(response_summary, Group == 'Go-only', Coil == 'PA'))$MEP
ap_response_go_only = (filter(response_summary, Group == 'Go-only', Coil == 'AP'))$MEP
pa_response_sst = (filter(response_summary, Group == 'SST', Coil == 'PA'))$MEP
ap_response_sst = (filter(response_summary, Group == 'SST', Coil == 'AP'))$MEP

response_meps = tibble(pa_response_go_only, ap_response_go_only, pa_response_sst, ap_response_sst)

lds_response <-  ggplot(response_meps, aes(x=pa_response_go_only, y=ap_response_go_only)) +
  geom_path(color = "blue", size=line_size) +
  geom_point(color = "blue", size = point_size) +
  geom_point(response_meps, mapping = aes(x=pa_response_go_only[1], y=ap_response_go_only[1]), color = "blue", shape = 8, size = point_size+2) +
  geom_path(response_meps, mapping = aes(x=pa_response_sst, y=ap_response_sst), color = "red", size=line_size) +
  geom_point(response_meps, mapping = aes(x=pa_response_sst, y=ap_response_sst), color = "red", size = point_size) +
  geom_point(response_meps, mapping = aes(x=pa_response_sst[1], y=ap_response_sst[1]), color = "red", shape = 8, size = point_size+2) +
  geom_abline(slope=1, intercept = 0, linetype = "dashed", size = line_size) +
  xlab("Normalised \n PA MEP amplitude") +
  ylab("Normalised \n AP MEP amplitude") +
  xlim(0,6) +
  ylim(0,6) +
  ggtitle("Response-locked") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", colour = "black", size = axis_text_size+5)) +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")

euclidean_cue_data = (filter(distance_data, Analysis == 'Cue', Group == 'Euclidean'))

euclidean_cue <- ggplot(euclidean_cue_data, aes(x=factor(Time),  y=Distance)) +
  geom_boxplot(aes(fill=Type)) +
  xlim("0","50","100","150","200","250","300") +
  xlab("Time from cue (ms)") +
  ylab("Euclidean \n distance") +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")

cosine_cue_data = (filter(distance_data, Analysis == 'Cue', Group == 'Cosine'))

cosine_cue <- ggplot(cosine_cue_data, aes(x=factor(Time),  y=Distance)) +
  geom_boxplot(aes(fill=Type)) +
  xlim("0","50","100","150","200","250","300") +
  xlab("Time from cue (ms)") +
  ylab("Cosine distance") +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")

euclidean_response_data = (filter(distance_data, Analysis == 'Response', Group == 'Euclidean'))

euclidean_response <- ggplot(euclidean_response_data, aes(x=factor(Time),  y=Distance)) +
  geom_boxplot(aes(fill=Type)) +
  #xlim("50 - 100","100 - 150","150 - 200","200 - 250","250 - 300","300 - 350") +
  xlab("Time from response (ms)") +
  ylab("Euclidean \n distance") +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")


cosine_response_data = (filter(distance_data, Analysis == 'Response', Group == 'Cosine'))

cosine_response <- ggplot(cosine_response_data, aes(x=factor(Time),  y=Distance)) +
  geom_boxplot(aes(fill=Type)) +
  #xlim("50 - 100","100 - 150","150 - 200","200 - 250","250 - 300","300 - 350") +
  xlab("Time from response (ms)") +
  ylab("Cosine distance") +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(axis.line.x = element_line(color="black", size = 1),
        axis.line.y = element_line(color="black", size = 1),
        axis.title.x = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.title.y = element_text(size = axis_text_size, face = "bold", colour = "black"),
        axis.text.x = element_text(size = tick_text_size, face = "bold", colour = "black"),
        axis.text.y = element_text(size = tick_text_size, face = "bold", colour = "black")) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  theme(legend.title = element_blank()) +
  theme(legend.position = "none")

combined_figure_2 <- ggarrange(lds_cue, lds_response, euclidean_cue, euclidean_response, cosine_cue, cosine_response, labels = c("A", "B", "C", "D", "E", "F"), common.legend = TRUE, legend="bottom", ncol = 2, nrow = 3)
combined_figure_2
