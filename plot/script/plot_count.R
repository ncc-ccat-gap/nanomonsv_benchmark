library(tidyverse)
library(wesanderson)

source("plot_conf.R")

D <- read_tsv("../output/benchmark.summary.count.txt")

D$Benchmark <- factor(D$Benchmark, 
                      level = c("Arora_2019", "Valle_Inclan_2020"),
                      label = c("Benchmark (Arora)", "Benchmark (Valle-Inclan)"))

D$Class <- factor(D$Class,
                  level = c("Detected", "Not detected", "New"),
                  label = c("SVs in benchmark dataset and called", "SVs in benchmark dataset and not called", "SVs not in benchmark dataset and called"))

D$Dataset <- factor(D$Dataset,
                  level = c("Original_ONT", "Valle_Inclan_ONT", "Valle_Inclan_PBS"),
                  label = c("ONT (Ours)", "ONT (PRJEB27698)", "PBS (PRJEB27698)"))


ggplot(D, aes(x = Dataset, y = Count, fill = Class)) + 
  geom_bar(stat = "identity", position = "dodge") +
  facet_grid(.~Benchmark) +
  my_theme() +
  theme(legend.position = "bottom",
        axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(fill = "", x = "Sequence data", y = "Number of SV calls") +
  scale_fill_manual(values = wes_palette("BottleRocket2", 3)) +
  guides(fill = guide_legend(nrow = 2)) 

ggsave("../output/benchmark_detection_count_summary.pdf", width = 10, height = 7, units = "cm")


D <- read_tsv("../output/benchmark.summary.ratio.txt")

D$Benchmark <- factor(D$Benchmark, 
                      level = c("Arora_2019", "Valle_Inclan_2020"),
                      label = c("Arora", "Valle-Inclan"))


D$Dataset <- factor(D$Dataset,
                    level = c("Original_ONT", "Valle_Inclan_ONT", "Valle_Inclan_PBS"),
                    label = c("ONT (Ours)", "ONT (PRJEB27698)", "PBS (PRJEB27698)"))

ggplot(D, aes(x = Precision, y = Recall, colour = Dataset, shape = Benchmark)) + geom_point() +
  my_theme() +
  theme(legend.position = "bottom", legend.box="vertical") +
  labs(colour = "Sequence data", shape = "Benchmark") +
  xlim(c(0, 1)) + ylim(c(0, 1)) +
  scale_colour_manual(values = wes_palette("Darjeeling1", 3))

ggsave("../output/benchmark_detection_ratio_summary.pdf", width = 9.5, height = 8, units = "cm")


D <- read_tsv("../output/benchmark2.summary.ratio.txt")

D$Benchmark <- factor(D$Benchmark, 
                      level = c("Arora_2019", "Valle_Inclan_2020"),
                      label = c("Arora", "Valle-Inclan"))


#D$Dataset <- factor(D$Dataset,
#                    level = c("nanomonsv", "sniffles2", "cutesv", "delly", "camphor", "svim"),
#                    label = c("nanomonsv", "Sniffles2-based method", "cuteSV-based method", "Delly-based method", "CAMPHORsomatic", "SVIM-based method"))
D$Dataset <- factor(D$Dataset,
                    level = c("nanomonsv", "sniffles2", "cutesv", "delly", "camphor", "svim", "savana_strict", "savana_lenient"),
                    label = c("nanomonsv", "Sniffles2-based method", "cuteSV-based method", "Delly-based method", "CAMPHORsomatic", "SVIM-based method", "SAVANA strict", "SAVANA lenient"))

ggplot(D, aes(x = Precision, y = Recall, colour = Dataset, shape = Benchmark)) + geom_point() +
  my_theme() +
  theme(legend.position = "bottom", legend.box="vertical") +
  labs(shape = "Benchmark", colour = "Method") +
  xlim(c(0, 1)) + ylim(c(0, 1)) +
  scale_colour_manual(values = c(wes_palette("FantasticFox1", 5)[2:5], wes_palette("Moonrise3", 5)[2:2], wes_palette("Rushmore1", 5)[3:3], wes_palette("GrandBudapest1", 4)[2:3])) +
  guides(colour = guide_legend(nrow = 2, byrow = TRUE))

#ggsave("../output/benchmark_detection_ratio_summary2.pdf", width = 10.5, height = 8, units = "cm")
ggsave("../output/benchmark_detection_ratio_summary2.pdf", width = 14, height = 8, units = "cm")


#D <- read_tsv("../output/COLO829.Arora_2019.proc.txt")
D <- read_tsv("../output/COLO829_T_kataoka.nanomonsv.Arora_2019.proc.txt")

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

