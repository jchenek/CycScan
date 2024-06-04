####################################################################################################################
#PATH input
all_path <- commandArgs(trailingOnly = TRUE)
coverm_reads_per_base <- all_path[1]
bam_total_reads <- all_path[2]
out_name <- all_path[3]


coverm_tsv <- read.delim(paste(coverm_reads_per_base), sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,
                           row.names = 1)
coverm_total <- read.delim(paste(bam_total_reads), sep = '\t', stringsAsFactors = FALSE, check.names = FALSE,
                           row.names = 1)


coverm_relative <- coverm_tsv
for(i in 1:length(coverm_relative[,1])){
  coverm_relative[i,] = (coverm_tsv[i,]/coverm_total[1,])*(10^9)
}

write.csv(coverm_relative,
          paste(out_name,".csv",sep=""),quote=F)
