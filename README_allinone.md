# nanomonsv_benchmark
a repository for nanomonsv paper

## 1. Set Up

Get this repository.

```
git clone --recursive https://github.com/ncc-gap/nanomonsv_benchmark.git
cd nanomonsv_benchmark
```

Pull apptainer images.

```
apptainer pull $PWD/image/minimap2_2.17.sif docker://aokad/minimap2:2.17
apptainer pull $PWD/image/nanomonsv_v0.5.0.sif docker://friend1ws/nanomonsv:v0.5.0
wget https://github.com/dellytools/delly/releases/download/v1.0.3/delly_v1.0.3.sif -P $PWD/image/
apptainer pull $PWD/image/sniffles2_2.0.7.sif docker://aokad/snilles2:2.0.7
apptainer pull $PWD/image/cutesv_2.0.0.sif docker://aokad/cutesv:2.0.0
apptainer pull $PWD/image/camphor_somatic_20221005.sif docker://aokad/camphor_somatic:20221005
apptainer pull $PWD/image/svim_2.0.0.sif docker://aokad/svim:2.0.0
apptainer pull $PWD/image/savana_1.0.3.sif docker://aokad/savana:1.0.3
apptainer pull $PWD/image/ob_utils_0.0.12c.sif docker://aokad/ob_utils:0.0.12c
apptainer pull $PWD/image/simulationsv-set_0.1.0.sif docker://aokad/simulationsv-set:0.1.0
apptainer pull $PWD/image/nanomonsv-tutorial_0.1.0.sif docker://aokad/nanomonsv-tutorial:0.1.0

# for bamtofastq
apptainer pull $PWD/image/bwa_alignment_0.2.0.sif docker://genomon/bwa_alignment:0.2.0
```

Download controlpanel. (nanomonsv)

```
mkdir -p $PWD/control_panel
wget https://zenodo.org/api/files/5c116b75-6ef0-4445-9fa8-c5989639da5f/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control.tar.gz -P $PWD/control_panel/
tar -xvf $PWD/control_panel/hprc_year1_data_freeze_nanopore_minimap2_2_24_merge_control.tar.gz -C $PWD/control_panel/
```

Download reference files to any location.
```
mkdir reference/
wget https://api.gdc.cancer.gov/data/254f697d-310d-4d7d-a27b-27fbf767a834 -O GRCh38.d1.vd1.fa.tar.gz
tar -zxvf GRCh38.d1.vd1.fa.tar.gz
wget https://api.gdc.cancer.gov/data/2c5730fb-0909-4e2a-8a7a-c9a7f8b2dad5 -O GRCh38.d1.vd1_GATK_indices.tar.gz
tar -zxvf GRCh38.d1.vd1_GATK_indices.tar.gz
```

As needed, specify the path to the apptainer.  
For examle,
```
ls $PWD/script/*.sh | xargs sed -i.bak 's;apptainer;/usr/local/package/apptainer/1.2.4/bin/apptainer;g'
```

Set up databases.

```
apptainer shell $PWD/image/nanomonsv-tutorial_0.1.0.sif
apptainer> cd $PWD/db
apptainer> bash run.sh
```

```
source ~/conda/x64/etc/profile.d/conda.sh
conda create -n nanomonsv_benchmark nanomonsv
~/conda/x64/envs/nanomonsv_benchmark/bin/pip install annot_utils
```

## 2. minimap2

```
REFERENCE=reference/GRCh38.d1.vd1.fa

qsub $PWD/script/minimap2.sh path/to/tumor/fastq.gz path/to/tumor.bam ${REFERENCE}
qsub $PWD/script/minimap2.sh path/to/normal/fastq.gz path/to/normal.bam ${REFERENCE}
```

### 3. Run

Execute script run.sh specifying the SV tool you want to use.
SVTOOL can take on the values "nanomonsv", "camphor", "savana", "delly", "sniffles2", "cutesv", "svim".
```
REFERENCE=reference/GRCh38.d1.vd1.fa
bash $PWD/run.sh ${SVTOOL} path/to/tumor.bam path/to/normal.bam output_dir ${REFERENCE}
```

**Attention**: case run camphor,
```
mkdir -p output_dir/camphor/fastq/
gunzip -c path/to/tumor/fastq.gz > output_dir/camphor/fastq/tumor.fastq

bash $PWD/run.sh camphor path/to/tumor.bam path/to/normal.bam output_dir ${REFERENCE} path/to/tumor.fastq
```

See outputs,
```
output_dir/benchmark/${SVTOOL}_sv.benchmark.result.txt
output_dir/benchmark/${SVTOOL}_sv.Arora_2019.txt
output_dir/benchmark/${SVTOOL}_sv.Valle-Inclan_2020.txt
```

## 4. Plot (FYI)

Set up conda.

```
source ~/conda/x64/etc/profile.d/conda.sh
conda create -n nanomonsv_benchmark_plot numpy r-base r-ggplot2 r-wesanderson r-tidyverse r-venndiagram
```

Run plot.
```
cd $PWD/plot
bash run.sh
```

