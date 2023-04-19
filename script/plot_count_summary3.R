library(tidyverse)
library(wesanderson)

source("plot_conf.R")

D <- read_tsv("../output/benchmark3.summary.ratio.txt")

D$Benchmark <- factor(D$Benchmark, 
                      level = c("Arora_2019", "Valle_Inclan_2020"),
                      label = c("Arora", "Valle-Inclan"))

D$Dataset <- factor(D$Dataset,
                    level = c("nanomonsv", "sniffles2", "cutesv", "delly", "camphor", "svim", "savana_strict", "savana_lenient"),
                    label = c("nanomonsv", "Sniffles2-based method", "cuteSV-based method", "Delly-based method", "CAMPHORsomatic", "SVIM-based method", "SAVANA strict", "SAVANA lenient"))

D$SV_Type <- factor(D$SV_Type,
                    level = c("BND", "DEL", "INS/DUP", "INV"),
                    label = c("BND", "DEL", "INS/DUP", "INV"))

ggplot(D, aes(x = Precision, y = Recall, colour = Dataset, shape = Benchmark)) + geom_point() +
  facet_grid(.~SV_Type) +
  my_theme() +
  theme(legend.position = "bottom", legend.box="vertical") +
  labs(shape = "Benchmark", colour = "Method") +
  xlim(c(0, 1)) + ylim(c(0, 1)) +
  scale_colour_manual(values = c(wes_palette("FantasticFox1", 5)[2:5], wes_palette("Moonrise3", 5)[2:2], wes_palette("Rushmore1", 5)[3:3], wes_palette("GrandBudapest1", 4)[2:3])) +
  guides(colour = guide_legend(nrow = 2, byrow = TRUE))

ggsave("../output/benchmark_detection_ratio_summary3.pdf", width = 24, height = 8, units = "cm")
