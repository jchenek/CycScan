#scripts updated on 2024/5/28
#make sure DEV_kegg_s1_fa_reformate.pl and DEV_kegg_s2_gene_2_ko_description.pl can be found in current path.

echo "####################################"
echo "Run this scripts after CycScan_seqs.fa was successfully created"
echo "Run this scripts under CycScan conda env"
echo "####################################"

perl DEV_kegg_s1_fa_reformate.pl CycScan_seqs.fa > CycScan_DB_seq.faa &
perl DEV_kegg_s2_gene_2_ko_description.pl CycScan_seqs.fa > CycScan_DB_anno.txt &
wait
diamond makedb --in CycScan_DB_seq.faa -d CycScan_DB.dmnd

rm ko_genes.txt
rm combined_gene_list.txt
rm CycScan_seqs.fa
rm -rf ko_gene_info

