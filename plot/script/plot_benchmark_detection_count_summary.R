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
