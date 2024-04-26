library(tidyverse)
library(wesanderson)

source("plot_conf.R")

#D <- read_tsv("../output/COLO829_T_kataoka.nanomonsv.Arora_2019.proc.txt")
D <- read_tsv("../output/sniffles2_sv.Arora_2019.proc.txt")

D$Is_detected <- factor(D$Is_detected,
    level = c(TRUE, FALSE),
    label = c("Detected", "Not detected"))

ggplot(D, aes(x = Mean_SR, y = Mean_PE, color = Is_detected)) +
    geom_point() +
    my_theme() +
    theme(legend.position = "bottom") +
    labs(color = "", x = "Mean SR count", y = "Mean PE count") +
    scale_colour_manual(values = rev(wes_palette("Darjeeling2", 2)))

ggsave("../output/COLO829.Arora_2019.SR_PE.pdf", width = 8, height = 8, units = "cm")
