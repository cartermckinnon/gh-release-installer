# gh-release-installer

A tool for installing software from GitHub releases.

⚠️ **Disclaimer:** This is not intended to be a package manager. This is often not the right tool for the job (but sometimes, it is).

## Setup

1. Make sure `gh-release-installer` is on your `PATH`.
2. *(Optional)* Symlink existing repository configurations for to `$HOME/.gh-release-installer`.
```
ln -s $(pwd)/repositories $HOME/.gh-release-installer
```

## Usage

To install the latest release of a supported repository:
```
gh-release-installer myorg/myrepo
```

Or to install a specific release, identified by the corresponding tag:
```
gh-release-installer myorg/myrepo v1.0.0
```

## Adding support for a repository

`gh-release-installer` delegates the details of individual repositories to configuration files, expected to be at `$HOME/.gh-release-installer`.
The structure of this directory is expected to look like:
```
$HOME/.gh-release-installer
└── my-github-org
    ├── my-repo.assets
    └── my-repo.install
```

1. **Write an `.assets` file.**

This file can be:
- A flat text file, with one file name per line.
- An executable that prints one file name per line. The targeted release tag is provided as the only argument to this executable. This executable will be invoked like:
```
my-repo.assets "v1.0.0"
```

2. **Write an `.install` file.**

This must be an executable that, provided the release tag and the path to the downloaded assets, performs the installation.
This executable will be invoked like:
```
my-repo.install "v1.0.0" "/tmp/myassets"
```
