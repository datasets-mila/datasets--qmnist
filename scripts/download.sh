#!/bin/bash
set -o errexit -o pipefail

# this script is meant to be used with 'datalad run'

for file_url in \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/qmnist-train-images-idx3-ubyte.gz qmnist-train-images-idx3-ubyte.gz" \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/qmnist-train-labels-idx2-int.gz qmnist-train-labels-idx2-int.gz" \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/qmnist-train-labels.tsv.gz qmnist-train-labels.tsv.gz" \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/qmnist-test-images-idx3-ubyte.gz qmnist-test-images-idx3-ubyte.gz" \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/qmnist-test-labels-idx2-int.gz qmnist-test-labels-idx2-int.gz" \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/qmnist-test-labels.tsv.gz qmnist-test-labels.tsv.gz" \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/xnist-images-idx3-ubyte.xz xnist-images-idx3-ubyte.xz" \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/xnist-labels-idx2-int.xz xnist-labels-idx2-int.xz" \
	"https://raw.githubusercontent.com/facebookresearch/qmnist/master/xnist-labels.tsv.xz xnist-labels.tsv.xz"
do
	echo ${file_url} | git-annex addurl -c annex.largefiles=anything --raw --batch --with-files
done

md5sum -c md5sums
md5sum *.tsv.gz >> md5sums
