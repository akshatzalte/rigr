#!/bin/bash
#SBATCH -J pcba_scaffold
#SBATCH -o pcba_scaffold-%j.out
#SBATCH -t 3-00:00:00
#SBATCH --exclusive
#SBATCH -N 1
#SBATCH -p xeon-g6-volta

results_dir=results
data_path=/home/gridsan/azalte/qmdata_shared/chemprop-v2-paper/chemprop_benchmark_v2/data/pcba_scaffold/data.csv
splits_path=../multiple_splits.json

#Training with optimized hyperparameters
chemprop train \
-t classification \
--data-path $data_path \
--splits-file $splits_path \
--num-workers 20 \
--epochs 50 \
--pytorch-seed 42 \
--aggregation norm \
--no-batch-norm \
--save-dir $results_dir \
--ensemble-size 2 \
--num-folds 5 \
--metrics prc \
--config-path best_config.toml
