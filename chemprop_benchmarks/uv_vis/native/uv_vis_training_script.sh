#!/bin/bash
#SBATCH -J uv_vis
#SBATCH -o uv_vis-%j.out
#SBATCH -t 4-00:00:00
#SBATCH --exclusive
#SBATCH -N 1
#SBATCH -p xeon-g6-volta

results_dir=results
data_path=/home/gridsan/azalte/qmdata_shared/chemprop-v2-paper/chemprop_benchmark_v2/data/multi_molecule/data.csv
splits_path=../multiple_splits.json

#Training with optimized hyperparameters
chemprop train \
-t regression \
-s smiles solvent \
--data-path $data_path \
--splits-file $splits_path \
--num-workers 20 \
--epochs 50 \
--pytorch-seed 42 \
--aggregation norm \
--no-batch-norm \
--save-dir $results_dir \
--ensemble-size 5 \
--num-folds 5 \
--metrics mae r2 \
--config-path best_config.toml
