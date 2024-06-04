#scripts updated on 2024/5/28
#make sure elemental_cycle_pathways.tsv can be found in current path.

echo "####################################"
echo "Make sure 'elemental_cycle_pathways.tsv' can be found in current path."
echo "####################################"
cp elemental_cycle_pathways.tsv ko_tmp
sed -i '1d' ko_tmp
mkdir ko_gene_info
cd ko_gene_info

#remove empty file
find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf

#download gene id annotated with target ko
cut -f 1 ../ko_tmp | sed 's/ko://' | while read id; do wget -nc http://rest.kegg.jp/link/genes/$id --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/'; done
find ./ -name "*" -type f -size 0c |xargs -n 1 rm -rf

cat K* | sed 's/ko://' > ko_genes.txt
mv ko_genes.txt ../
cd ../

echo "####################################"
echo "ko id in elemental_cycle_pathways.tsv :"
less ko_tmp | wc -l
rm ko_tmp
echo "downloaded ko txt in ko_gene_info :"
ls ko_gene_info/ | wc -l
echo "if numbers are not equal, pls rerun the script, the downloaded data will be kept"
echo "####################################"
