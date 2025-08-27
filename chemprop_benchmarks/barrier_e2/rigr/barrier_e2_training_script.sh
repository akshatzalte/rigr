#!/bin/bash -l
echo 'date: ' $(date)
conda activate chemprop

results_dir="results"
data_path="/home/akshatz/bond_order_free/barriers_e2/dataset/e2_data.csv"
splits_path="../multiple_splits.json"

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
--reaction-columns AAM \
--keep-h \
--ensemble-size 5 \
--num-folds 5 \
--metrics mae \
--config-path best_config.toml \
--accelerator gpu \
--devices 1 \
--molecule-featurizers charge 

echo 'date: ' $(date)