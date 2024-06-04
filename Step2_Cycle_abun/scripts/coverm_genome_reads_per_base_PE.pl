#!/usr/bin/perl -w
use warnings;
#Usage: 
#perl .pl <IN number_of_threads> <IN a_txt_containning_path_of_PE_fq> <IN genome_dir> <IN path_to_cycscan>
#README:
#the list of path looks like this:
#"A_id\tA_PATH_1.fq\tA_PATH_2.fq\nB_id\tB_PATH_1.fq\tB_PATH_2.fq\nC_id\tC_PATH_1.fq\tC_PATH_2.fq\n"

($cpu, $fq_list, $ref, $path) = @ARGV;

open OU2, ">./coverm_com";

$path1 = "";
$path2 = "";
open IN2, "$fq_list";
while(<IN2>){
#	print"$_";
	chomp;
	$PE1 = (split /\t/,$_)[1];
	$PE2 = (split /\t/,$_)[2];
	$path1 = "$path1 $PE1";
	$path2 = "$path2 $PE2";
}
close IN2;
print OU2 "coverm genome -1 $path1 -2 $path2 --genome-fasta-files $ref\/*.fa* --methods reads_per_base --output-file coverm.tsv --min-covered-fraction 0 --min-read-percent-identity 95 --min-read-aligned-percent 75 --threads $cpu 2> coverm_2_out\n";
print OU2 "perl $path/Step2_Cycle_abun/scripts/dev_coverm_out_to_total_reads.pl coverm_2_out\n";

close OU2;
system ("sh coverm_com");
system ("rm coverm_com");
