# Demo of JupyterWith

* [JupyterWith](https://www.tweag.io/posts/2019-02-28-jupyter-with.html) ([repo](https://github.com/tweag/jupyterWith))
* [jupyter-vim](https://github.com/jwkvam/jupyterlab-vim)

## Install

First install direnv and allow it for this directory. Then `cd` to this
directory and install the jupyterlab extensions:

```
generate-directory jupyterlab_vim
```

## Use

For Python, use kernel `Python3 - IPythonKernel`.
For R, use kernel `R - JuniperKernel`.

### Local Launch

`cd` to this directory and run:

```
jupyter lab
```

TODO: can I just run `./launch`?

### Remote Launch

```
~/launch code/jupyterlab-demo
```

If `~/launch` doesn't exist on your local machine, copy it from this directory.

## Notes

Need to set `update = FALSE` in this line for it to work with Nix:

```R
p_load(load.libs, update = FALSE, character.only = TRUE)
```

## jupyterWith

Setup the `jupyterWith` subtree, if not done already:

```
git remote add jupyterWith git@github.com:ariutta/jupyterWith.git
git subtree add --prefix jupyterWith jupyterWith master --squash
```

Sync subtree repo:

```
git subtree pull --prefix jupyterWith jupyterWith master --squash
git subtree push --prefix jupyterWith jupyterWith master
```
