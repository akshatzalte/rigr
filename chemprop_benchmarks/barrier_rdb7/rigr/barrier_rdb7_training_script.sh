#!/bin/bash -l
echo 'date: ' $(date)
conda activate chemprop

results_dir="results"
data_path="/home/akshatz/bond_order_free/barriers_rdb7/dataset/rdb7_data.csv"
splits_path="../multiple_splits.json"

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
--save-dir $results_dir \
--reaction-columns smiles \
--add-h \
--keep-h \
--ensemble-size 5 \
--num-folds 5 \
--metrics mae rmse \
--config-path best_config.toml \
--accelerator gpu \
--devices "1," \
--molecule-featurizers charge \

echo 'date: ' $(date)