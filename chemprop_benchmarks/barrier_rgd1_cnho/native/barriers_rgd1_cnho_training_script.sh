#!/bin/bash
#SBATCH -J barriers_rgd1_cnho
#SBATCH -o barriers_rgd1_cnho-%j.out
#SBATCH -t 3-00:00:00
#SBATCH --exclusive
#SBATCH -N 1
#SBATCH -p xeon-g6-volta

results_dir=results
data_path=/home/gridsan/azalte/qmdata_shared/chemprop-v2-paper/chemprop_benchmark_v2/data/barriers_rgd1/data.csv
splits_path=../multiple_splits.json

#Training with optimized hyperparameters
chemprop train \
-t regression \
--data-path $data_path \
--splits-file $splits_path \
--num-workers 20 \
--epochs 50 \
--pytorch-seed 42 \
--aggregation norm \
--no-batch-norm \
--reaction-columns smiles \
--keep-h \
--save-dir $results_dir \
--ensemble-size 5 \
--num-folds 5 \
--metrics mae \
--config-path best_config.toml
