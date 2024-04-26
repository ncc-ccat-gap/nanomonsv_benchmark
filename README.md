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
apptainer pull $PWD/image/ob_utils_0.0.12c.sif docker://aokad/ob_utils:0.0.12c
apptainer pull $PWD/image/simulationsv-set_0.1.0.sif docker://aokad/simulationsv-set:0.1.0
apptainer pull $PWD/image/nanomonsv-tutorial_0.1.0.sif docker://aokad/nanomonsv-tutorial:0.1.0
```

```
apptainer shell $PWD/image/nanomonsv-tutorial_0.1.0.sif
apptainer> cd $PWD/db
apptainer> bash run.sh
```

### 2. Run

nanomonsv

```
REFERENCE=reference/GRCh38.d1.vd1.fa
NANOMON_TXT=path/to/sample.nanomonsv.result.txt
NANOMON_VCF=path/to/sample.nanomonsv.result.vcf

bash script/filt_nanomonsv.sh ${NANOMON_TXT} ${NANOMON_VCF} ./output_dir ${REFERENCE}
```

Other SV tool you want to use.
SVTOOL can take on the values "camphor", "savana", "delly", "sniffles2", "cutesv", "svim".
```
REFERENCE=reference/GRCh38.d1.vd1.fa
bash script/filt_svtools.sh ${SVTOOL} ${OUTPUT_TUMOR} ${OUTPUT_NORMAL} ./output_dir
```

```
# if $SVTOOL = "camphor"
OUTPUT_TUMOR=path/to/somatic_SV.vcf
OUTPUT_NORMAL=None

# if $SVTOOL = "savana"
OUTPUT_TUMOR=path/to/*.sv_breakpoints.vcf
OUTPUT_NORMAL=None

# if [ $SVTOOL = "svim" ]
OUTPUT_TUMOR=path/to/tumor/variants.vcf
OUTPUT_NORMAL=path/to/normal/variants.vcf


# if [ $SVTOOL = "delly" ]
OUTPUT_TUMOR=path/to/tumor/{delly}.bcf
OUTPUT_NORMAL=path/to/normal/{delly}.bcf

# if [ $SVTOOL = "sniffles2" ]
OUTPUT_TUMOR=path/to/tumor/{sniffles2}.vcf
OUTPUT_NORMAL=path/to/normal/{sniffles2}.vcf

# if [ $SVTOOL = "cutesv" ]
OUTPUT_TUMOR=path/to/tumor/{cutesv}.vcf
OUTPUT_NORMAL=path/to/normal/{cutesv}.vcf
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

