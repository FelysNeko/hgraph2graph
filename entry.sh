conda create -n hierg2g python==3.10 -y
conda activate hierg2g

pip install rdkit
pip install torch

python get_vocab.py --ncpu 20 < data/qed/mols.txt > data/qed/vocab.txt

python preprocess.py --train data/qed/train_pairs.txt --vocab data/qed/vocab.txt --ncpu 20
mkdir train_processed
mv tensor* train_processed/

python translate.py \
    --test data/qed/valid.txt \
    --vocab data/qed/vocab.txt \
    --model ckpt/translation/model.5 \
    --num_decode 20 > results.csv