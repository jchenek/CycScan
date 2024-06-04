#!/usr/bin/perl -w
use warnings;
use Getopt::Std;
use vars qw($opt_i $opt_f $opt_t $opt_p $opt_h);
getopts('i:f:t:p:h');

if($opt_h || !defined($opt_i) || !defined($opt_p) || !defined($opt_f) || !defined($opt_t)){
#usage
print "Usage:\nMake sure you are in CycScan conda environment.\nCommand:\n";
print "perl /PATH/TO/Cycabun.pl -i /PATH/TO/YOUR/fa_dir -f fq_list -t cpu_number -p /PATH/TO/CycScan_dir\n";
print "the fq_list looks like this:\n";
print "A_id\tA_PATH_1.fq\tA_PATH_2.fq\nB_id\tB_PATH_1.fq\tB_PATH_2.fq\nC_id\tC_PATH_1.fq\tC_PATH_2.fq\n";
}else{
#define variables
$genomes_path = $opt_i;
$CycScan_PATH = $opt_p;
$fq_path = $opt_f;
$cpu = $opt_t;

#output pipeline
$file = $genomes_path;
$file_name = (split /\//,$file)[-1];

open OU2, ">./Cycabun_com";
print OU2 "find $genomes_path -name \"\*\" -type f -size 0c \| xargs -n 1 rm -rf \n";
print OU2 "perl $CycScan_PATH\/Step2_Cycle_abun/scripts/coverm_genome_reads_per_base_PE.pl $cpu $fq_path $genomes_path $CycScan_PATH\n";
print OU2 "Rscript $CycScan_PATH\/Step2_Cycle_abun/scripts/coverm_contig_relative.R coverm.tsv bam_total_reads $file_name \n";
print OU2 "mkdir -p workfiles\n";
print OU2 "mv coverm\* workfiles\n";
print OU2 "mv bam_total\* workfiles\n";

system("sh Cycabun_com");
system("rm ./Cycabun_com");

print "###############################################################################\n";
print "###############################################################################\n";
print "###### Cycabun pipeline is finished!\n###### pls check the result file $file_name\.csv\n";
print "###############################################################################\n";
print "###############################################################################\n";
}