with import <nixpkgs> {};
with pkgs.lib.strings;
let
#  jupyter = import (builtins.fetchGit {
#    url = https://github.com/tweag/jupyterWith;
#    rev = "";
#  }) {};

  jupyter = import (./jupyterWith/default.nix) {};

  juniper = jupyter.kernels.juniperWith {
    # Identifier that will appear on the Jupyter interface.
    name = "JuniperKernel";
    # Libraries (R packages) to be available to the kernel.
    packages = p: with p; [
      pacman
      ggplot2
      xts
      DOSE
      GO_db
      GSEABase
      org_Hs_eg_db ## Human-specific
      clusterProfiler
      plyr  ## for ldply
      dplyr
      tidyr
      magrittr
      stringr
      rWikiPathways
    ];
    # Optional definition of `rPackages` to be used.
    # Useful for overlaying packages.
    rPackages = pkgs.rPackages;
  };

  iPython = jupyter.kernels.iPythonWith {
    name = "IPythonKernel";
    packages = p: with p; [ numpy ipython_sql ];
  };

  iHaskell = jupyter.kernels.iHaskellWith {
    name = "haskell";
    packages = p: with p; [ hvega formatting ];
  };

  jupyterEnvironment =
    jupyter.jupyterlabWith {
      kernels = [ iPython iHaskell juniper ];
      ## The generated directory goes here
      directory = ./jupyterlab;
    };
in
  jupyterEnvironment.env
