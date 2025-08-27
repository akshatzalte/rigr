#!/bin/bash -l
echo 'date: ' $(date)
conda activate chemprop

results_dir2=results_sampl_production
data_path=/home/akshatz/bond_order_free/logp/dataset/logP/data.csv
splits_path=../multiple_splits.json
path=/home/akshatz/bond_order_free/logp/dataset/logP/logP_without_overlap.csv

#Train production model
chemprop train \
-t regression \
--data-path $path \
--splits-file $splits_path \
--epochs 40 \
--aggregation norm \
--no-batch-norm \
--save-dir $results_dir2 \
--ensemble-size 5 \
--num-folds 5 \
--config-path best_config.toml \
--accelerator gpu \
--devices 1 \
--molecule-featurizers charge

#Predict on Sample 6
chemprop predict \
--test-path "/home/akshatz/bond_order_free/logp/dataset/logP/sampl6_experimental.csv" \
--preds-path $results_dir2/pred_SAMPL6.csv \
--model-path $results_dir2 \
--smiles-columns "Isomeric SMILES" \
--devices 1 \
--molecule-featurizers charge

echo SAMPL6  >> $results_dir2/sampl.csv
python -c 'import pandas as pd; from sklearn import metrics; print("rmse", metrics.mean_squared_error(pd.read_csv("results_sampl_production/pred_SAMPL6.csv")["logP"],pd.read_csv("/home/akshatz/bond_order_free/logp/dataset/logP/sampl6_experimental.csv")["logP mean"],squared=False))' >> $results_dir2/sampl.csv

#Predict on Sample 7
chemprop predict \
--test-path "/home/akshatz/bond_order_free/logp/dataset/logP/sampl7_experimental.csv" \
--preds-path $results_dir2/pred_SAMPL7.csv \
--model-path $results_dir2 \
--smiles-columns "Isomeric SMILES" \
--devices 1 \
--molecule-featurizers charge

echo SAMPL7 >> $results_dir2/sampl.csv
python -c 'import pandas as pd; from sklearn import metrics; print("rmse", metrics.mean_squared_error(pd.read_csv("results_sampl_production/pred_SAMPL7.csv")["logP"],pd.read_csv("/home/akshatz/bond_order_free/logp/dataset/logP/sampl7_experimental.csv")["logP mean"],squared=False))' >> $results_dir2/sampl.csv

#Predict on Sample 9
chemprop predict \
--test-path "/home/akshatz/bond_order_free/logp/dataset/logP/sampl9_experimental.csv" \
--preds-path $results_dir2/pred_SAMPL9.csv \
--model-path $results_dir2 \
--smiles-columns smiles \
--devices 1 \
--molecule-featurizers charge

echo SAMPL9 >> $results_dir2/sampl.csv
python -c 'import pandas as pd; from sklearn import metrics; print("rmse", metrics.mean_squared_error(pd.read_csv("results_sampl_production/pred_SAMPL9.csv")["logP"],pd.read_csv("/home/akshatz/bond_order_free/logp/dataset/logP/sampl9_experimental.csv")["new_logPexp_reviewed"],squared=False))' >> $results_dir2/sampl.csv

echo "Saved results to" $results_dir2"/sampl.csv"
cat  >> $results_dir2/sampl.csv