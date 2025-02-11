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


Shiozaki, T., Fujiwara, A., Ijichi, M., Harada, N., Nishino, S., Nishi, S., Nagata, T., & Hamasaki, K. (2018). Diazotroph community structure and the role of nitrogen fixation in the nitrogen cycle in the Chukchi Sea (western Arctic Ocean). Limnology and Oceanography, 63(5), 2191–2205. https://doi.org/10.1002/lno.10933
```

