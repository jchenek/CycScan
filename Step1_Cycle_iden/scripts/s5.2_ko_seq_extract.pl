#!/usr/bin/perl -w
use warnings;
#Usage: perl .pl <IN elemental_cycle_pathways.tsv> <IN dir_diamond_out_1> <IN dir_prodigal_cds_f*a> <IN path_to_CycScan>
#make sure dev_ko_gene_extract.pl existed

($elemental_cycle_pathways, $dir_diamond_out_1, $dir_prodigal_cds_fa, $path_to_CycScan) = @ARGV ;

open OU, ">./ko_extract_com";
print OU "mkdir CycScan_seqs_extract\n";
open IN, "<$elemental_cycle_pathways";
<IN>; #ignore the header
while (<IN>) {
chomp;
s/\r//;
$id=(split /\t/,$_)[0]; #<------target ko id

my$DIR_PATH = $dir_diamond_out_1;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
foreach my$file (@filelist) {
if($file =~ /tsv$/){
$filename = $file;
$filename =~ s/\.cds.m6out.*tsv//;
print OU "perl $path_to_CycScan\/Step1_Cycle_iden/scripts/dev_ko_gene_extract.pl $id $dir_diamond_out_1\/$file $dir_prodigal_cds_fa\/$filename\* $path_to_CycScan CycScan_seqs_extract\/$filename\_$id\.fa \n";
}
}
}
close IN;
close OU;
system("sh ko_extract_com");
system("rm ko_extract_com");

my$DIR_PATH = $dir_diamond_out_1;
opendir DIR, ${DIR_PATH} or die "can not open dir \"$DIR_PATH\"\n";
my@filelist = readdir DIR;
foreach my$file (@filelist) {
if($file =~ /tsv$/){
$filename = $file;
$filename =~ s/\.cds.m6out.*tsv//;
system("mkdir CycScan_seqs_extract/$filename");
system("mv ./CycScan_seqs_extract/$filename\_* CycScan_seqs_extract/$filename");
}
}
