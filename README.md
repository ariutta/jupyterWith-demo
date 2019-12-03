# Demo of JupyterWith

* [JupyterWith](https://www.tweag.io/posts/2019-02-28-jupyter-with.html) ([repo](https://github.com/tweag/jupyterWith))
* [jupyter-vim](https://github.com/jwkvam/jupyterlab-vim)

## Install

```
nix-shell
generate-directory jupyterlab_vim
# ctrl-d to exit shell
```

## Use

```
nix-shell --command "jupyter lab"
```

For Python, use kernel `Python3 - IPythonKernel`.
For R, use kernel `R - JuniperKernel`.

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
