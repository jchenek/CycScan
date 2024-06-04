#!usr/bin/perl
#perl .pl <IN ko_genes.txt>
#scripts updated on 2024/5/28

open IN, "$ARGV[0]";

#get combined gene list
open OU, ">./combined_gene_list.txt";
$i = 0;
while(<IN>){
	chomp;
	$gene_id = (split /\t/,$_)[1];
	print OU "$gene_id";
	if($i < 9){
		print OU "+";
		$i = $i + 1;
	}else{
		print OU "\n";
		$i = 0;
	}
}
close OU;

#wget seqs
system("mkdir CycScan_seqs");
#system("find ./CycScan_seqs -name "*" -type f -size 0c |xargs -n 1 rm -rf");
open IN, "./combined_gene_list.txt";
while(<IN>){
	chomp;
	$com_id = $_;
	$ou_id = $com_id;
	$ou_id =~ s/[\:+]/_/g;
#	print "$com_id\t$ou_id\n";
	system("wget -nc http://rest.kegg.jp/get/$com_id/aaseq -O ./CycScan_seqs/$ou_id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' -U 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.1 Safari/605.1.15'");
}
#system("find ./CycScan_seqs -name "*" -type f -size 0c |xargs -n 1 rm -rf");

print "####################################\n";
print "items in combined_gene_list.txt: \n";
system("less combined_gene_list.txt | wc -l");
print "downloaded items in CycScan_seqs: \n";
system("ls CycScan_seqs/ | wc -l");
print "####################################\n";
print "if the number of downloaded items is LOWER than that in combined_gene_list.txt, pls run this command first:\n";
print "> find \.\/CycScan_seqs -name \"\*\" -type f -size 0c \|xargs -n 1 rm -rf\n";
print "then rerun this perl script again, the downloaded data will be kept\n";
print "if the number of downloaded items is more than that in combined_gene_list.txt (one more), it is fine\n";
print "####################################\n";
print "if the number of downloaded item number is EQUAL to or ONE MORE than items in combined_gene_list.txt, pls concatenate seq by running:\n";
print "> find \.\/CycScan_seqs -name \"\*\" -type f \|xargs cat \> CycScan_seqs.fa\n";
print "####################################\n";
