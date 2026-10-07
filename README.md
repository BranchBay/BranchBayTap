# BranchBay packages

Package definitions for [BranchBay](https://branchbay.dev), the native Git
client. The files themselves are on https://releases.branchbay.dev; this
repository only tells each package manager where they are. Everything here
is rewritten by the release scripts, so edits belong there.

The default definitions follow the stable channel. Each has a beta variant
that follows the beta channel instead.

## Homebrew

```sh
brew tap branchbay/tap https://github.com/BranchBay/BranchBayTap.git
brew trust branchbay/tap
brew install --cask branchbay        # macOS
brew install branchbay               # Linux
```

Beta: `branchbay@beta` for the cask, `branchbay-beta` for the formula.

## Nix

```sh
nix run github:BranchBay/BranchBayTap
nix profile install github:BranchBay/BranchBayTap
```

Beta: add `#branchbay-beta`. In a NixOS or Home Manager configuration, add
this repository as a flake input and put
`inputs.branchbay.packages.${system}.branchbay` in your packages.

## Arch Linux

The `aur/` directory holds the `branchbay-bin` and `branchbay-beta-bin`
packages as published on the AUR:

```sh
git clone https://aur.archlinux.org/branchbay-bin.git
cd branchbay-bin && makepkg -si
```

## Gentoo

This repository is also an ebuild repository:

```sh
sudo eselect repository add branchbay git https://github.com/BranchBay/BranchBayTap.git
sudo emaint sync -r branchbay
echo 'dev-vcs/branchbay-bin all-rights-reserved' | sudo tee /etc/portage/package.license/branchbay
echo 'dev-vcs/branchbay-bin' | sudo tee /etc/portage/package.accept_keywords/branchbay
sudo emerge --ask dev-vcs/branchbay-bin
```

## Debian and Ubuntu

The APT repository lives on the release host, not here:

```sh
curl -fsSL https://releases.branchbay.dev/apt/branchbay-archive-keyring.gpg | sudo tee /usr/share/keyrings/branchbay-archive-keyring.gpg >/dev/null
curl -fsSL https://releases.branchbay.dev/apt/branchbay.sources | sudo tee /etc/apt/sources.list.d/branchbay.sources >/dev/null
sudo apt update && sudo apt install branchbay
```
