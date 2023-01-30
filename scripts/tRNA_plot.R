#!/usr/bin/env Rscript

library(ggplot2)

df <- read.delim(file = "characteristics.tsv", header = TRUE)

ggplot(df, aes(Genus, tRNA))+
  geom_boxplot()+
  geom_dotplot(binaxis = 'y',
               stackdir = 'center',
               dotsize = .5,
               fill="red")+
  labs(x="Genus",
       y="tRNAs")
