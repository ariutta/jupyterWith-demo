with import <nixpkgs> { overlays = [ (import ./python-overlay.nix) ]; };
with pkgs.lib.strings;
let

  # cloned my fork of jupyterWith as a sibling of this directory
  jupyter = import (../jupyterWith/default.nix) {
    directory = "./share-jupyter";
    # TODO: would the format below be better? regardless, it doesn't work right now:
#    serverextensions = with pkgs.python3Packages; [
#      psycopg2
#      jupyterlab_sql
#    ];
    # so I had to use this:
    serverextensions = [
      "psycopg2"
      "jupyterlab_sql"
    ];
    overlays = [ (import ./python-overlay.nix) ];
  };

#  jupyter = import (builtins.fetchGit {
#    url = https://github.com/tweag/jupyterWith;
#    rev = "";
#  }) { overlays = [ (import ./python-overlay.nix) ]; };
#  #}) {};

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

  mypython = pkgs.python3.withPackages(ps: with ps; [
    numpy
    ipython_sql
    psycopg2
    jupyterlab_sql
  ]);

  iPythonWithPackages = jupyter.kernels.iPythonWith {
    name = "IPythonKernel";

    # TODO: I shouldn't need any of these if I'm using overlays, right?
    #python3 = pkgs.python3Packages;
    #python3 = pkgs.python3;
    #python3 = mypython;

    packages = p: with p; [
      # sql magic for jupyterlab
      ipython_sql

      # for jupyterlab-sql.
      # TODO: do these need to be specified here, or just in serverextensions above?
      psycopg2
      jupyterlab_sql

      # python dependencies not specifically for jupyterlab
      numpy
    ];
  };

  jupyterEnvironment =
    jupyter.jupyterlabWith {
      kernels = [ iPythonWithPackages juniper ];
      ## The generated directory goes here
      directory = ./share-jupyter;
      extraPackages = p: [
        p.ps
        p.lsof
        mypython
      ];
    };
in
  jupyterEnvironment.env
