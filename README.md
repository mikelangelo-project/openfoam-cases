Example OpenFOAM datasets for testing OpenFOAM on OSv.

Uses git LFS, so install it before cloning.
From https://git-lfs.github.com/:
```
# Fedora
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | sudo bash
sudo dnf install git-lfs
```

After checkout, add it to OSv `config.json` repositories:
```
osv/config.json:
{
...
    "repositories": [
        "${OSV_BASE}/apps",
        "${OSV_BASE}/modules"
        , "${OSV_BASE}/../openfoam-cases"
    ]
```