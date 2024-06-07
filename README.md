CycScan (Cycle Scan)
=======

CycScan is a pipeline to investigate elemental cycles in metagenomic assemblies or metagenome-assembled genomes (MAGs).

- `Before running`: Please make sure `CycScan_DB.dmnd` `CycScan_DB_anno.txt` `elemental_cycle_pathways.tsv` are available in dir `CycScan_DB` before run this pipeline. If not, pls prepare these files using provided scripts.

Installation
---------------

### Step 1. Create a conda environment
```sh
conda create -n CycScan -y
conda activate CycScan

#mamba is recommend
mamba install wget parafly diamond=2.0.15 prodigal=2.6.3 coverm -y 
#or
conda install wget parafly diamond=2.0.15 prodigal=2.6.3 coverm -y
```

### Step 2. Download or clone OSDB repository
```sh
git clone https://github.com/jchenek/CycScan.git
```

### Step 3. Prepare database (run this step in dir 'CycScan_DB')
```sh
sh DB_prep_s1_get_ko_genes.sh
perl DB_prep_s2_get_gene_seqs.pl ko_genes.txt
sh DB_prep_s3_make_DB_and_sapce_release.sh
```

Usage
-----

- `Step 1`: Cycles identification

You may check cycle maps in dir 'Cycle_MAPs'.

```sh
conda activate OSDB
perl /PATH/TO/Cyciden.pl -i /PATH/TO/YOUR/fa_dir -p /PATH/TO/CycScan_dir
```

- `Step 2`: Cycles abundance

```sh
conda activate OSDB
perl /PATH/TO/Cycabun.pl -i /PATH/TO/YOUR/fa_dir -f fq_list -t cpu_number -p /PATH/TO/CycScan_dir
```
