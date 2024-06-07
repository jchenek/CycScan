#!/usr/bin/perl -w
use warnings;
use Getopt::Std;
use vars qw($opt_i $opt_p $opt_h);
getopts('i:p:h');

if($opt_h || !defined($opt_i) || !defined($opt_p)){
#usage
print "Usage:\nMake sure you are in CycScan conda environment.\nCommand:\n";
print "perl /PATH/TO/Cyciden.pl -i /PATH/TO/YOUR/fa_dir -p /PATH/TO/CycScan_dir\n";
}else{
#define variables
$current_path = $ENV{'PWD'};
$genomes_path = $opt_i;
$CycScan_PATH = $opt_p;
#print "$genomes_path\n$current_path\n$CycScan_PATH\n";

#output pipeline
open OU2, ">./Cyciden_com";
print OU2 "cd $genomes_path\n";
print OU2 "export user_genome_PATH=\"\$\(pwd\)\"\n";
print OU2 "cd \.\.\/\n";

print OU2 "perl $CycScan_PATH\/Step1_Cycle_iden/scripts/s1.1_genomes_in_dir_label.pl \$user_genome_PATH $CycScan_PATH\n";
print OU2 "perl $CycScan_PATH\/Step1_Cycle_iden/scripts/s1.2_genomes_in_dir_reformate.pl label $CycScan_PATH\n";
print OU2 "perl $CycScan_PATH\/Step1_Cycle_iden/scripts/s2_genomes_prodigal.pl reformated/ \n";
print OU2 "perl $CycScan_PATH\/Step1_Cycle_iden/scripts/s3_cds_diamond.pl prodigal/cds_faa/ $CycScan_PATH\/CycScan_DB/CycScan_DB.dmnd\n";
print OU2 "find . -wholename \"\./diamond_out/\*\" -type f -size 0c | xargs -n 1 rm -f\n";
print OU2 "perl $CycScan_PATH\/Step1_Cycle_iden/scripts/s4_kegg_anno.pl $CycScan_PATH\/CycScan_DB/CycScan_DB_anno.txt diamond_out/ diamond_out/\n";
print OU2 "perl $CycScan_PATH\/Step1_Cycle_iden/scripts/s5.1_ko_summary.pl $CycScan_PATH\/CycScan_DB/elemental_cycle_pathways.tsv diamond_out_2/ > Cyciden_summary.tsv\n";
print OU2 "cat prodigal/cds_fna//* > prodigal.tmp.fa \n";
print OU2 "perl $CycScan_PATH\/Step1_Cycle_iden/scripts/dev_genomes_reformat.pl prodigal.tmp.fa > prodigal.fa \n";
print OU2 "rm prodigal.tmp.fa \n";
print OU2 "perl $CycScan_PATH\/Step1_Cycle_iden/scripts/s5.2_ko_seq_extract.pl $CycScan_PATH\/CycScan_DB/elemental_cycle_pathways.tsv diamond_out_1/ prodigal.fa $CycScan_PATH\n";
print OU2 "mkdir workfiles\nmv diamond_out* workfiles/\nmv label/ workfiles/\nmv reformated/ workfiles/\nmv prodigal/ workfiles/\ncd $current_path\n";
system("sh Cyciden_com");
system("rm ./Cyciden_com");
system("rm ./prodigal.fa");

print "###############################################################################\n";
print "###############################################################################\n";
print "###### Cyciden pipeline is finished!\n###### 'Cyciden_summary.tsv' file showes how many merker genes were detected in each sample.\n###### 'CycScan_seqs_extract' dir contains seqs of each marker gene in each sample\n";
print "###############################################################################\n";
print "###############################################################################\n";
}
