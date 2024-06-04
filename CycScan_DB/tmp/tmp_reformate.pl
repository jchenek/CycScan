#!usr/bin/perl
use warnings;
#usage: perl .pl <IN original.fa> > <OU reformated.fa>

open IN, "$ARGV[0]";
open OU1, ">./tem.reformated";
while(<IN>){
	s/\r//g;
	chomp;
	s/  ko://;
	s/; .*//;
	s/ /\t/;
	print OU1 "$_\n";
}
close IN;
close OU1;

