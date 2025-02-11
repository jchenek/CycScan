CycScan (Cycle Scan)
=======

CycScan is a pipeline to investigate elemental cycles in metagenomic assemblies or metagenome-assembled genomes (MAGs).

- `Before running`: Please make sure `CycScan_DB.dmnd` `CycScan_DB_anno.txt` `elemental_cycle_pathways.tsv` are available in dir `CycScan_DB` before run this pipeline. If not, pls prepare these files using provided scripts.

Installation
---------------

### Step 1. Create a conda environment
```sh
conda create -n cycscan -y
conda activate cycscan

#mamba is recommend
mamba install wget parafly diamond=2.0.15 prodigal=2.6.3 coverm -y 
#or
#conda install wget parafly diamond=2.0.15 prodigal=2.6.3 coverm -y
```

### Step 2. Download or clone CycScan repository
```sh
git clone https://github.com/jchenek/CycScan.git
```

### Step 3. Prepare database (run this step in dir 'CycScan_DB')
```sh
#run following scripts one by one, pay attention to the std output info of each script
sh DB_prep_s1_get_ko_genes.sh
perl DB_prep_s2_get_gene_seqs.pl ko_genes.txt
sh DB_prep_s3_make_DB_and_sapce_release.sh
```

Usage
-----

- `Step 1`: Cycles identification

You may check cycle maps in dir 'Cycle_MAPs'.

```sh
conda activate cycscan
perl /PATH/TO/Cyciden.pl -i /PATH/TO/YOUR/fa_dir -p /PATH/TO/CycScan_dir
```

Customized nifH database
-----
- The nifH gene has been commonly used as a marker to assess the distribution and community of diazotrophs (Bonnet et al., 2023; Delmont et al., 2022; Shiozaki et al., 2018). However, recent work by Mise et al. (2021) has shown that approximately 20% of genomes that contain the nifH gene lack the nifDK genes, which encode essential subunits of nitrogenases (Mise et al., 2021). This suggests that nifH alone is not necessarily to be an indicator of diazotrophs. To address this issue, we only considered a genome that contains the three genes encoding catalytic proteins (nifHDK) essential for N fixation as a potential diazotroph genome. 
- Using the Diaiden pipeline, we identified 3,316 potential diazotroph genomes from the Genome Taxonomy Database (GTDB) release R214. In addition, we compiled the 48 diazotroph MAGs recently recovered from the worldwide sunlit ocean (Delmont et al., 2022), resulting in a comprehensive diazotroph database comprising 3,364 genomes. We retrieved nifH gene sequences from these potential diazotroph genomes to create a customized nifH gene database.
- This database can be found in the directory `Customized nifH database`

- `References`
- Bonnet, S., Benavides, M., Le Moigne, F. A. C., Camps, M., Torremocha, A., Grosso, O., Dimier, C., Spungin, D., Berman-Frank, I., Garczarek, L., & Cornejo-Castillo, F. M. (2023). Diazotrophs are overlooked contributors to carbon and nitrogen export to the deep ocean. The ISME Journal, 17(1), 47–58. https://doi.org/10.1038/s41396-022-01319-3
- Delmont, T. O., Pierella Karlusich, J. J., Veseli, I., Fuessel, J., Eren, A. M., Foster, R. A., Bowler, C., Wincker, P., & Pelletier, E. (2022). Heterotrophic bacterial diazotrophs are more abundant than their cyanobacterial counterparts in metagenomes covering most of the sunlit ocean. The ISME Journal, 16(4), 927–936. https://doi.org/10.1038/s41396-021-01135-1
- Mise, K., Masuda, Y., Senoo, K., & Itoh, H. (2021). Undervalued Pseudo- nifH Sequences in Public Databases Distort Metagenomic Insights into Biological Nitrogen Fixers. mSphere, 6(6), e00785-21. https://doi.org/10.1128/msphere.00785-21
- Shiozaki, T., Fujiwara, A., Ijichi, M., Harada, N., Nishino, S., Nishi, S., Nagata, T., & Hamasaki, K. (2018). Diazotroph community structure and the role of nitrogen fixation in the nitrogen cycle in the Chukchi Sea (western Arctic Ocean). Limnology and Oceanography, 63(5), 2191–2205. https://doi.org/10.1002/lno.10933


