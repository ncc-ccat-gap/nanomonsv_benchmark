library(tidyverse)
library(VennDiagram)

D <- read_tsv("../output/benchmark.summary.count.txt")

gen_venn <- function(seqdata, benchmark, vfilename, label1, label2, label_main) {
  

  tD <- D %>% filter(Dataset == seqdata, Benchmark == benchmark)

  tcount1 <- tD %>% filter(Class == "Detected") %>% pull(Count)
  tcount2 <- tD %>% filter(Class == "Not detected") %>% pull(Count)
  tcount3 <- tD %>% filter(Class == "New") %>% pull(Count)

  sv_identified <- seq(1, tcount1 + tcount3)
  sv_benchmark <- seq(tcount3 + 1, tcount1 + tcount2 + tcount3)


  # venn.diagram(x = list(sv_identified, sv_benchmark), 
  # draw.pairwise.venn(area1 = length(sv_identified), 
  #                    area2 = length(sv_benchmark), 
  #                    cross.area = length(intersect(sv_identified, sv_benchmark)),

  venn.diagram(x = list(sv_identified, sv_benchmark), 
               category.names = c(label1, label2), 
               filename = vfilename,
               output = TRUE,
               main = label_main,
               main.fontfamily = "Helvetica",
               main.cex = 0.8,
               main.pos = c(0.5, 1.0),
               imagetype = "png",
               # inverted = TRUE,
               width = 7,
               height = 4,
               cex = 0.8,
               units = "cm",
               resolution = 600,
               fontfamily = "Helvetica",
               margin = 0.05,
               col = c(alpha("#0B775E", 0.6), alpha("#F2300F", 0.6)),
               fill = c(alpha("#0B775E",0.4), alpha("#F2300F",0.4)),
               cat.cex = 0.8,
               cat.pos = c(30, -30), # c(30, -30)
               cat.dist = c(0.03, 0.01), # c(0.03, 0.02)
               cat.fontfamily = "Helvetica",
               cat.col = c("#0B775E", "#F2300F"),
               ext.line.lty = c(3, 3),
               ext.length = c(0.85, 0.85),
               ext.pos = 180,
               rotation.degree = 180,
               lwd = 1,
   )
}


gen_venn("Original_ONT", "Arora_2019", "../output/venn_arrora_kataoka.png", "nanomonsv", "High-confidence SVs", "Benchmark (Arora)")
gen_venn("Original_ONT", "Valle_Inclan_2020", "../output/venn_valle-inclan_kataoka.png", "nanomonsv", "High-confidence SVs", "Benchmark (Valle-Inclan)")

gen_venn("Valle_Inclan_ONT", "Arora_2019", "../output/venn_arrora_PRJEB27698-ONT.png", "nanomonsv", "High-confidence SVs", "Benchmark (Arora)")
gen_venn("Valle_Inclan_ONT", "Valle_Inclan_2020", "../output/venn_valle-inclan_PRJEB27698-ONT.png", "nanomonsv", "High-confidence SVs", "Benchmark (Valle-Inclan)")

gen_venn("Valle_Inclan_PBS", "Arora_2019", "../output/venn_arrora_PRJEB27698-PBS.png", "nanomonsv", "High-confidence SVs", "Benchmark (Arora)")
gen_venn("Valle_Inclan_PBS", "Valle_Inclan_2020", "../output/venn_valle-inclan_PRJEB27698-PBS.png", "nanomonsv", "High-confidence SVs", "Benchmark (Valle-Inclan)")
