library(tidyverse)
library(wesanderson)

source("plot_conf.R")

check_precision_recall <- function(D, read_num) {
  
  total_call_num <- nrow(D %>% filter(Supporting_Read_Num_Tumor >= read_num))
  tp_num_arora <- nrow(D %>% filter(Supporting_Read_Num_Tumor >= read_num) %>% filter(!is.na(Is_Arora)))
  tp_num_valle <- nrow(D %>% filter(Supporting_Read_Num_Tumor >= read_num) %>% filter(!is.na(Is_Valle_Inclan)))
  
  precision_arora <- tp_num_arora / total_call_num
  precision_valle <- tp_num_valle / total_call_num
  
  recall_arora <- tp_num_arora / 75
  recall_valle <- tp_num_arora / 58
  
  return(c(precision_arora, recall_arora, precision_valle, recall_valle))

}

get_PR_data <- function(sv_data, method) {
  
  D <- read_tsv(sv_data)

  P <- rbind(
    check_precision_recall(D, 3), 
    check_precision_recall(D, 4),
    check_precision_recall(D, 5), 
    check_precision_recall(D, 6),
    check_precision_recall(D, 7),
    check_precision_recall(D, 8)
  )
  
  P <- cbind(3:8, P)  

  colnames(P) <- c("Supporting_Read_Num", "Precision_Arora", "Recall_Arora", 
                   "Precision_Valle-Inclan", "Recall_Valle-Inclan")
  
  P2 <- as_tibble(P) %>% gather("key", "value", -Supporting_Read_Num)
  
  P2$Measurement <- str_split(P2$key, "_", simplify = TRUE)[,1]
  P2$Benchmark <- str_split(P2$key, "_", simplify = TRUE)[,2]
  P2$Method <- method
  
  return(P2 %>% select(Supporting_Read_Num, Measurement, Benchmark, Method, Ratio = value))
}

#ABC順にする -> 白石さん指定順に変更
input_file_dir <- "/home/aiokada/sandbox/nanomonsv_benchmark/output"
PR1 <- get_PR_data("../../output/nanomonsv/benchmark/nanomonsv_sv.benchmark.result.txt", "nanomonsv")
PR2 <- get_PR_data("../../output/sniffles2/benchmark/sniffles2_sv.benchmark.result.txt", "Sniffles2-based method")
PR3 <- get_PR_data("../../output/cutesv/benchmark/cutesv_sv.benchmark.result.txt", "cuteSV-based method")
PR4 <- get_PR_data("../../output/delly/benchmark/delly_sv.benchmark.result.txt", "Delly-based method")
PR5 <- get_PR_data("../../output/camphor/benchmark/camphor_sv.benchmark.result.txt",  "CAMPHORsomatic")
PR6 <- get_PR_data("../../output/svim/benchmark/svim_sv.benchmark.result.txt", "SVIM-based method")
PR7 <- get_PR_data("../../output/savana/benchmark/savana_sv.benchmark.result.txt", "SAVANA")

PR <- bind_rows(PR1, PR2, PR3, PR4, PR5, PR6, PR7)

PR$Method <- factor(PR$Method, levels = c("nanomonsv","Sniffles2-based method","cuteSV-based method","Delly-based method","CAMPHORsomatic","SVIM-based method", "SAVANA"))

ggplot(PR, 
       aes(x = Supporting_Read_Num, y = Ratio, colour = Measurement)) + 
  geom_point() +
  geom_line() +
  facet_grid(Benchmark~Method) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.2)) +
  labs(x = "Minimum supporting read number", y = "Ratio", colour = "") +
  my_theme() +
  scale_colour_manual(values = wes_palette("Darjeeling1", 5)[c(1, 5)]) +
  theme(legend.position = "bottom",
        panel.grid.major = element_line()) 
  
ggsave("../output/read_num_change.pdf", width = 24, height = 8, units = "cm")

