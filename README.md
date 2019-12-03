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

## Notes

Need to set `update = FALSE` in this line for it to work with Nix:

```R
p_load(load.libs, update = FALSE, character.only = TRUE)
```
