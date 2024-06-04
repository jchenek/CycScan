#!/usr/bin/perl -w
#usage: perl .pl <IN ko_id> <IN path_to_diamond_out_1_file> <IN path_to_prodigal_fa> <IN path_to_diaiden> <output_name>
#make sure dev_label_fa.pl existed
#make sure dev_fa_reformat_v2.pl existed

use warnings;
($ko, $path_diamond, $path_prodigal_fa, $path, $out_name) = @ARGV ;

system("perl $path\/Step1_Cycle_iden/scripts/dev_genomes_reformat.pl $path_prodigal_fa > tmp.$ko\.prodigal.fa");

open IN1, "$path_diamond";
open OU1, ">./tmp.$ko\.id";
while(<IN1>){
	chomp;
	if(m/$ko/){
	$ID = (split /\t/,$_)[0];
	print OU1 "$ID\n";
	}
}

system("perl $path\/Step1_Cycle_iden/scripts/dev_extract_target_contig_from_fa.pl tmp.$ko\.id tmp.$ko\.prodigal.fa > $out_name");
system("rm ./tmp.$ko\.*");
