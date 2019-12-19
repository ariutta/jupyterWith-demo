with import <nixpkgs> { overlays = [ (import ./python-overlay.nix) ]; };
with pkgs.lib.strings;
let
  # This property is just for jupyter server extensions, but it is
  # OK if the server extension includes a lab extension.
  serverextensions = p: with p; [
    jupyterlab_sql
  ];

  # TODO: specify a lab extensions property

  jupyter = import (

#    # for dev, clone a jupyterWith fork as a sibling of demo directory
#    ../jupyterWith/default.nix

    # for "prod"
    builtins.fetchGit {
      url = https://github.com/ariutta/jupyterWith;
      ref = "proposals";
    }

  ) {
    directory = "./share-jupyter";
    serverextensions = serverextensions;
    overlays = [ (import ./python-overlay.nix) ];
  };

  #########################
  # R
  #########################

  myRPackages = p: with p; [
    pacman
    dplyr
    ggplot2
    knitr
    purrr
    readr
    stringr
    tidyr
  ];

  myR = [ R ] ++ (myRPackages pkgs.rPackages);

  juniper = jupyter.kernels.juniperWith {
    # Identifier that will appear on the Jupyter interface.
    name = "JuniperKernel";
    # Libraries (R packages) to be available to the kernel.
    packages = myRPackages;
    # Optional definition of `rPackages` to be used.
    # Useful for overlaying packages.
    # TODO: why not just do this in overlays above?
    #rPackages = pkgs.rPackages;
  };

  #########################
  # Python
  #########################

  myPythonPackages = (p: (with p; [
    numpy

    # TODO: ipython_sql isn't a serverextension, but it IS specifically for
    # augmenting jupyter. Where should we specify it?
    # sql magic for jupyterlab
    ipython_sql
    # same thing for nb_black
    nb_black
  ]) ++
  # TODO: it would be nice not have to specify serverextensions here, but the
  # current jupyterLab code needs it to be specified both here and above.
  (serverextensions p));

  myPython = pkgs.python3.withPackages(myPythonPackages);

  iPythonWithPackages = jupyter.kernels.iPythonWith {
    name = "IPythonKernel";

    # TODO: I shouldn't need to set this if I'm using overlays, right?
    #python3 = pkgs.python3Packages;

    packages = myPythonPackages;
  };

  jupyterEnvironment =
    jupyter.jupyterlabWith {
      kernels = [ iPythonWithPackages juniper ];

      ## The generated directory goes here
      directory = ./share-jupyter;
      extraPackages = p: [
        # needed by jupyterlab-launch
        p.ps
        p.lsof

        # needed to make server extensions work
        myPython

        # TODO: do we still need these for lab extensions?
        nodejs
        yarn

        # optionals below
        myR
      ];
    };
in
  jupyterEnvironment.env
