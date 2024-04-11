# nanomonsv_paper
a repository for nanomonsv paper

## 1. svtools

### 1-1. Set Up

download bam
```
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR275/ERR2752451/colo829.normal.ngmlr.sorted.bam -O bam/ERR2752451.bam 
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR275/ERR2752452/colo829.tumor.ngmlr.sorted.merged.bam -O bam/ERR2752452.bam 
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR280/ERR2808247/hg19.COLO_829N.bam -O bam/ERR2808247.bam 
wget http://ftp.sra.ebi.ac.uk/vol1/run/ERR280/ERR2808248/hg19.COLO_829T.bam -O bam/ERR2808248.bam 
```

download reference files
```
cd simulation_lr_sv
mkdir reference/
cd reference
wget https://api.gdc.cancer.gov/data/254f697d-310d-4d7d-a27b-27fbf767a834 -O GRCh38.d1.vd1.fa.tar.gz
tar -zxvf GRCh38.d1.vd1.fa.tar.gz
wget https://api.gdc.cancer.gov/data/2c5730fb-0909-4e2a-8a7a-c9a7f8b2dad5 -O GRCh38.d1.vd1_GATK_indices.tar.gz
tar -zxvf GRCh38.d1.vd1_GATK_indices.tar.gz

# download reference file for minimap2
aws s3 cp s3://genomon-bucket/GDC.GRCh38.d1.vd1/minimap2/GRCh38.d1.vd1.mmi ./

# donwload controlpanel (nanomonsv)
mkdir -p $PWD/control_panel
wget https://zenodo.org/api/files/5c116b75-6ef0-4445-9fa8-c5989639da5f/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control.tar.gz -O $PWD/control_panel/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control.tar.gz
tar -xvf $PWD/control_panel/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control.tar.gz
```

singularity images
```
singularity pull ./image/nanomonsv_v0.5.0.sif docker://friend1ws/nanomonsv:v0.5.0
wget https://github.com/dellytools/delly/releases/download/v1.0.3/delly_v1.0.3.sif -O ./image/delly_v1.0.3.sif
singularity pull $PWD/image/sniffles2_2.0.7.sif docker://aokad/snilles2:2.0.7
singularity pull $PWD/image/cutesv_2.0.0.sif docker://aokad/cutesv:2.0.0
singularity pull $PWD/image/camphor_somatic_20221005.sif docker://aokad/camphor_somatic:20221005
singularity pull $PWD/image/svim_2.0.0.sif docker://aokad/svim:2.0.0
singularity pull $PWD/image/savana_0.2.3.sif docker://aokad/savana:0.2.3
singularity pull $PWD/image/savana_1.0.0.sif docker://aokad/savana:1.0.0
singularity pull $PWD/image/savana_1.0.3.sif docker://aokad/savana:1.0.3
```

wget https://github.com/ncc-ccat-gap/simulation_sv_set/archive/refs/tags/v0.2.0.zip
unzip v0.2.0.zip
mv simulation_sv_set-0.2.0 simulation_sv_set

## 1-2. minimap2

bam to fastq
```
qsub script/bamtofastq.sh ERR2752451 COLO829_R_Nanopore
qsub script/bamtofastq.sh ERR2752452 COLO829_T_Nanopore
qsub script/bamtofastq.sh ERR2808247 COLO829_R_PacBio
qsub script/bamtofastq.sh ERR2808248 COLO829_T_PacBio
```

minimap2
```
qsub script/minimap2.sh COLO829_R_Nanopore
qsub script/minimap2.sh COLO829_T_Nanopore
qsub script/minimap2.sh COLO829_R_PacBio
qsub script/minimap2.sh COLO829_T_PacBio
qsub script/minimap2_kataoka.sh COLO829
qsub script/minimap2_kataoka.sh COLO829BL
```

### 1-3. Run

```
cd svtools/script
bash run.sh
```

## 2. bencmark

### 2-1. Set Up

Set up conda.

```
conda create -n nanomonsv_benchmark nanomonsv
conda activate nanomonsv_benchmark
conda install nanomonsv_benchmark numpy r-base r-ggplot2 r-wesanderson r-tidyverse r-venndiagram

~/conda/x64/envs/nanomonsv_benchmark/bin/pip install annot_utils
```

Set up databases.

```
cd bencmark/db
bash run.sh
```

### 2-2. Run

See, bencmark/script/runall.sh, edit pathes to SV files.
Then, run script.
```
cd bencmark/script
bash runall.sh
```
