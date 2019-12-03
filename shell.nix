with import <nixpkgs> {};
#with import <nixpkgs> { overlays = [ (import ./python-overlay.nix) ]; };
with pkgs.lib.strings;
let
  #python-overlay = (import ./python-overlay.nix) {};
  pkgs = import <nixpkgs> { inherit overlays; };
  jupyterlab-sql = (callPackage ./jupyterlab-sql/requirements.nix {}).packages.jupyterlab-sql;
  #ipython-sql = (callPackage ./ipython-sql/requirements.nix {}).packages.ipython-sql;
  #ipython-sql = callPackage ./ipython-sql-raw/default.nix {};

#  jupyter = import (builtins.fetchGit {
#    url = https://github.com/tweag/jupyterWith;
#    rev = "";
#  }) { overlays = [ python-overlay ]; };

  jupyter = import (builtins.fetchGit {
    url = https://github.com/tweag/jupyterWith;
    rev = "";
  }) { overlays = [ (import ./python-overlay.nix) ]; };

#  jupyter = import (builtins.fetchGit {
#    url = https://github.com/tweag/jupyterWith;
#    rev = "";
#  }) {};

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

#  iPython = jupyter.kernels.iPythonWith {
#    name = "python";
#    packages = p: with p; [ numpy ipython-sql ] ++ [ jupyterlab-sql ];
#    #packages = p: with p; [ numpy ipython-sql ] ++ [ jupyterlab-sql ];
#  };

#  python3 = pkgs.python3.override (old: {
#    packageOverrides =
#      pkgs.lib.composeExtensions
#        (old.packageOverrides or (_: _: {}))
#        packageOverrides;
#  });

#  python = let
#    packageOverrides = self: super: {
#      ipython-sql = super.buildPythonPackage rec {
#        pname = "ipython-sql";
#        version = "0.3.9";
#        name = "${pname}-${version}";
#
#        src = super.fetchPypi {
#          inherit pname version;
#          sha256 = "1vf3dhvdynd3wiwsw3a67fshy06r6d17qb1wns7rvf1q3wvzd1vi";
#        };
#
#        propagatedBuildInputs = with python3.pkgs; [
#          prettytable
#          ipython
#          sqlalchemy
#          sqlparse
#          six
#          ipython_genutils
#        ];
#
#        doCheck = false;
#
#        meta = with stdenv.lib; {
#          description = "Introduces a %sql (or %%sql) magic.";
#          longDescription = ''
#            Introduces a %sql (or %%sql) magic.
#            Connect to a database, using SQLAlchemy connect strings, then issue SQL
#            commands within IPython or IPython Notebook.
#            '';
#          homepage = "https://pypi.org/project/ipython-sql/";
#          license = licenses.mit;
#          maintainers = with maintainers; [ ];
#        };
#      };
#    };
#  in pkgs.python3.override {inherit packageOverrides; self = python;};

  iPythonWithPackages = jupyter.kernels.iPythonWith {
    #python3 = python;
    name = "IPythonKernel";
    #packages = p: with p; [ numpy ipython_sql jupyterlab-sql ];
    packages = p: with p; [ numpy ipython_sql ];
#    packages = p:
#      let
#        ipython_sql = callPackage ./ipython-sql-raw/default.nix {};
#      in
#        [ numpy ipython_sql ];
  };


  iHaskell = jupyter.kernels.iHaskellWith {
    name = "haskell";
    packages = p: with p; [ hvega formatting ];
  };

  jupyterEnvironment =
    jupyter.jupyterlabWith {
      kernels = [ iPythonWithPackages iHaskell juniper ];
      ## The generated directory goes here
      directory = ./jupyterlab;
    };
in
  jupyterEnvironment.env
