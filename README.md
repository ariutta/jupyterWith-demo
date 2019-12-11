# Demo of JupyterWith

This is a demo of using my forked version of [jupyterWith](https://github.com/ariutta/jupyterWith).

References:

* [JupyterWith](https://www.tweag.io/posts/2019-02-28-jupyter-with.html) ([repo](https://github.com/tweag/jupyterWith))
* [jupyter-vim](https://github.com/jwkvam/jupyterlab-vim)

## Install

First install direnv. Then `cd` to this directory, allow direnv, and install
extensions for jupyter lab and server:

```
./install-extensions
```

## Use

For Python, use kernel `Python3 - IPythonKernel`.
For R, use kernel `R - JuniperKernel`.

### Local Launch

`cd` to this directory and run:

```
./jupyterlab-launch
```

### Remote Launch

```
~/jupyterlab-launch nixos.gladstone.internal:code/jupyterlab-demo
```

If `~/jupyterlab-launch` doesn't exist on your local machine, copy it from this directory.

## Notes

Need to set `update = FALSE` in this line for it to work with Nix:

```R
p_load(load.libs, update = FALSE, character.only = TRUE)
```
