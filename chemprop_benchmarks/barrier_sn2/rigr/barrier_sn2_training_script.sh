#!/bin/bash -l
echo 'date: ' $(date)
conda activate chemprop

results_dir="results"
data_path="/home/akshatz/bond_order_free/barriers_sn2/dataset/sn2_data.csv"
splits_path="../multiple_splits.json"

#Training with optimized hyperparameters
chemprop train \
-t regression \
--data-path $data_path \
--splits-file $splits_path \
--molecule-featurizers charge \
--num-workers 20 \
--epochs 200 \
--pytorch-seed 42 \
--aggregation norm \
--no-batch-norm \
--accelerator gpu \
--devices "1," \
--reaction-columns AAM \
--add-h \
--keep-h \
--save-dir $results_dir \
--ensemble-size 5 \
--num-folds 5 \
--metrics mae rmse \
--config-path best_config.toml

echo 'date: ' $(date)