#!/bin/bash
#SBATCH -J barriers_cycloadd
#SBATCH -o barriers_cycloadd-%j.out
#SBATCH -t 3-00:00:00
#SBATCH --exclusive
#SBATCH -N 1
#SBATCH -p xeon-g6-volta

results_dir=results
data_path=/home/gridsan/azalte/qmdata_shared/chemprop-v2-paper/chemprop_benchmark_v2/data/barriers_cycloadd/data.csv
splits_path=../multiple_splits.json

#Training with optimized hyperparameters
chemprop train \
-t regression \
--data-path $data_path \
--splits-file $splits_path \
--num-workers 20 \
--epochs 200 \
--pytorch-seed 42 \
--aggregation norm \
--no-batch-norm \
--save-dir $results_dir \
--keep-h \
--ensemble-size 5 \
--num-folds 5 \
--metrics mae \
--reaction-columns rxn_smiles \
--target-columns G_act \
--config-path best_config.toml
