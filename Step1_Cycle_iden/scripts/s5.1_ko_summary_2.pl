#!/usr/bin/perl -w
use warnings;

#usage: perl s6_ko_summary_2.pl <IN elemental_cycle_pathways.tsv> <IN ko_summary.tsv>
($elemental_cycle_pathways,$ko_summary) = @ARGV ;

%hash1 = ();
%hash2 = ();

open IN1, "$elemental_cycle_pathways";
while(<IN1>){
	chomp;
	$id = (split /\t/,$_)[0];
	$hash1{$id}=$_;
}
close IN1;

open IN2, "$ko_summary";
while(<IN2>){
	chomp;
	$id = (split /\t/,$_)[0];
	$all = $_;
	$all =~ s/$id\t//;
	$hash2{$id}=$all;
}
close IN2;

open IN1, "$elemental_cycle_pathways";
while(<IN1>){
	chomp;
	$id = (split /\t/,$_)[0];
	print "$hash1{$id}\t$hash2{$id}\n";
}
close IN1;




