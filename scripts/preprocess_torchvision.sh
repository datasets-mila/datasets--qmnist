#!/bin/bash
set -o errexit -o pipefail

# this script is meant to be used with 'datalad run'

_SNAME=$(basename "$0")

source scripts/utils.sh echo -n

mkdir -p logs/

python3 -m pip install -r scripts/requirements_torchvision.txt

# Move data files to QMNIST/raw as it is where torchvision looks for QMNIST raw files
mkdir -p QMNIST/raw
git mv *-idx[23]-*.[gx]z QMNIST/raw
git-annex fsck QMNIST/raw

python3 scripts/preprocess_torchvision.py \
	1>>logs/${_SNAME}.out_$$ 2>>logs/${_SNAME}.err_$$

# Delete raw files
git rm -rf *.[gx]z QMNIST/raw/*.[gx]z md5sums

git-annex add -c annex.largefiles=anything QMNIST
