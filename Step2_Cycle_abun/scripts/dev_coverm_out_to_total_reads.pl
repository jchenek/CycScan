#!/usr/bin/perl -w
use warnings;
#Usage: perl coverm_out_to_total_reads.pl <IN coverm_2_out>

($coverm_2_out) = @ARGV;

open OU, ">./bam_total_reads";
print OU "bam_file";
open II, "$coverm_2_out";
while (<II>) {
	chomp;
	if (m/In sample/) { #<------adjust to get bam
	$bam = $_;
	$bam =~ s{.*In sample \'(.*)\',.*}{$1};
	print OU "\t$bam";
	}
}
close II;
print OU "\n";

print OU "total_reads";
open II, "$coverm_2_out";
while (<II>) {
	chomp;
	if (m/In sample/) { #<------adjust to get bam
	$total = $_;
	$total =~ s{.*reads mapped out of (.*) total \(.*}{$1};
	print OU "\t$total";
	}
}
close II;
print OU "\n";

print OU "mapped_reads";
open II, "$coverm_2_out";
while (<II>) {
	chomp;
	if (m/In sample/) { #<------adjust to get bam
	$mapped = $_;
	$mapped =~ s{.*, found (.*) reads mapped out of.*}{$1};
	print OU "\t$mapped";
	}
}
close II;
print OU "\n";