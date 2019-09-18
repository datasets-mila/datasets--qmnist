import torchvision

for w in torchvision.datasets.QMNIST.subsets.keys():
    torchvision.datasets.QMNIST(".", what=w, download=True)
