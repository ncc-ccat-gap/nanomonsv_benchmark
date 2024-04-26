library(tidyverse)
library(wesanderson)

source("plot_conf.R")

D <- read_tsv("../output/benchmark4.summary.ratio.txt")

D$Benchmark <- factor(D$Benchmark, 
                      level = c("Arora_2019", "Valle_Inclan_2020"),
                      label = c("Arora", "Valle-Inclan"))

D$ControlPanel <- factor(D$ControlPanel,
                    level = c(TRUE, FALSE),
                    label = c("Use", "No Use"))

D$Dataset <- factor(D$Dataset,
                    level = c("Valle_Inclan_ONT", "Valle_Inclan_PBS"),
                    label = c("ONT (PRJEB27698)", "PBS (PRJEB27698)"))

D2 <- D %>% filter(Dataset == "PBS (PRJEB27698)")

ggplot(D2, aes(x = Precision, y = Recall, colour = ControlPanel, shape = Benchmark)) + geom_point() +
  my_theme() +
  theme(legend.position = "bottom", legend.box="vertical") +
  labs(colour = "Control panel", shape = "Benchmark") +
  xlim(c(0, 1)) + ylim(c(0, 1)) +
  scale_colour_manual(values = wes_palette("Darjeeling1", 3))

ggsave("../output/benchmark_detection_ratio_summary4.pdf", width = 9.5, height = 8, units = "cm")
