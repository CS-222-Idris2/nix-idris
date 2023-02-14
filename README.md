# nix-idris
A simple flake-based development environment for Idris 2 projects.

Note: most of the work in this repository will become obsolete when
https://github.com/NixOS/nixpkgs/issues/214412 is resolved.

## Enabling nix flakes

Make sure this line is in `~/.config/nix/nix.conf`:

```
experimental-features = nix-command flakes
```

For a quick setup:

```sh
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## Creating a new project

```sh
# create new directory
mkdir my-project
cd my-project

# initialize git
git init

# load the nix-idris template
nix flake init -t github:CS-222-Idris2/nix-idris
nix flake lock

# first commit
git add -A
git commit -m "initial commit"
```

## Accessing the development environment

To enter the development shell:

```sh
nix develop
```

If you want to use vscodium (free-licensed vscode) through the development environment:

```sh
nix develop .#with-vscodium
```

If you have nix-direnv set up:

```sh
echo "use flake" > .envrc
# or `echo "use flake .#with-vscodium" > .envrc`
direnv allow
```
