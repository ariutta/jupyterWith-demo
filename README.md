# Demo of JupyterWith

This is a demo of using my forked version of [jupyterWith](https://github.com/ariutta/jupyterWith).

## Install

### Base

First install [jupyterlab-launch](github.com/ariutta/jupyterlab-launch) (add it to `PATH` on client/local machine) and direnv (on server/local machine). Then `cd` to this directory and run `direnv allow`.

### Extensions

Nix expressions for Python and R packages are in the `nixpkgs` directory. The ones in there now include some of my most commonly used packages, but not all of them are necessarily required for this demo.

_TODO_: Do I need to install `jupyter_bokeh` as an extension, or is it automatically installed? I think it's normally automatically installed, but maybe this is a non-standard installation, requring me to manually install it?

## Use

For Python, use kernel `Python3 - IPythonKernel`.
For R, use kernel `R - JuniperKernel`.

### Local Launch

`cd` to this directory and run:

```
jupyterlab-launch
```

### Remote Launch

```
jupyterlab-launch nixos.gladstone.internal:code/jupyterlab-demo
```

If `~/jupyterlab-launch/jupyterlab-launch` doesn't exist on your local machine, copy it from this directory.

### nbconvert

Convert ipynb to other formats, e.g.:

```
jupyter nbconvert --to pdf python_demo.ipynb
```

## Notes

Need to set `update = FALSE` in this line for it to work with Nix:

```R
p_load(load.libs, update = FALSE, character.only = TRUE)
```

## Sync jupyterlab-launch

Long-term, some of these packages may be included in Nix packages. But for the packages not yet included,
you can use a subtree to pull them into your own project:

Setup the `jupyterlab-launch` subtree, if not done already:

```
git remote add jupyterlab-launch git@github.com:ariutta/jupyterlab-launch.git
git subtree add --prefix jupyterlab-launch jupyterlab-launch master --squash
```

Sync subtree repo:

```
git subtree pull --prefix jupyterlab-launch jupyterlab-launch master --squash
git subtree push --prefix jupyterlab-launch jupyterlab-launch master
```

## References:

- [JupyterWith](https://www.tweag.io/posts/2019-02-28-jupyter-with.html) ([repo](https://github.com/tweag/jupyterWith))
- [jupyter-vim](https://github.com/jwkvam/jupyterlab-vim)
