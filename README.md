# nanomonsv_paper
a repository for nanomonsv paper

## 1. Set Up

Set up conda.

```
conda create -n nanomonsv_benchmark nanomonsv
conda activate nanomonsv_benchmark
conda install nanomonsv_benchmark numpy r-base r-ggplot2 r-wesanderson r-tidyverse r-venndiagram

~/conda/x64/envs/nanomonsv_benchmark/bin/pip install annot_utils
```

Set up databases.

```
cd db
bash run.sh
```

## 2. Run

See, script/runall.sh, edit pathes to SV files.
Then, run script.
```
cd script
bash runall.sh
```
