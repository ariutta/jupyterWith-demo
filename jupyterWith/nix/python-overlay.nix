_: pkgs:
let
  packageOverrides = selfPythonPackages: pythonPackages: {

    jupyterlab = pythonPackages.jupyterlab.overridePythonAttrs (_:{
      doCheck = false;
    });

    nbconvert = pythonPackages.nbconvert.overridePythonAttrs (_:{
      doCheck = false;
    });

    jupyter_contrib_core = pythonPackages.buildPythonPackage rec {
      pname = "jupyter_contrib_core";
      version = "0.3.3";

      src = pythonPackages.fetchPypi {
        inherit pname version;
        sha256 = "e65bc0e932ff31801003cef160a4665f2812efe26a53801925a634735e9a5794";
      };
      doCheck = false;  # too much
      propagatedBuildInputs = [
        pythonPackages.traitlets
        pythonPackages.notebook
        pythonPackages.tornado
        ];
    };

    jupyter_nbextensions_configurator = pythonPackages.buildPythonPackage rec {
      pname = "jupyter_nbextensions_configurator";
      version = "0.4.1";

      src = pythonPackages.fetchPypi {
        inherit pname version;
        sha256 = "e5e86b5d9d898e1ffb30ebb08e4ad8696999f798fef3ff3262d7b999076e4e83";
      };

      propagatedBuildInputs = [
        selfPythonPackages.jupyter_contrib_core
        pythonPackages.pyyaml
        ];

      doCheck = false;  # too much
    };

    jupyter_c_kernel = pythonPackages.buildPythonPackage rec {
      pname = "jupyter_c_kernel";
      version = "1.2.2";
      doCheck = false;

      src = pythonPackages.fetchPypi {
        inherit pname version;
        sha256 = "e4b34235b42761cfc3ff08386675b2362e5a97fb926c135eee782661db08a140";
      };

      meta = with pkgs.stdenv.lib; {
        description = "Minimalistic C kernel for Jupyter";
        homepage = https://github.com/brendanrius/jupyter-c-kernel/;
        license = licenses.mit;
        maintainers = [];
      };
    };

    ipython_sql = pythonPackages.buildPythonPackage rec {
      pname = "ipython-sql";
      version = "0.3.9";
      name = "${pname}-${version}";

      src = pythonPackages.fetchPypi {
        inherit pname version;
        sha256 = "1vf3dhvdynd3wiwsw3a67fshy06r6d17qb1wns7rvf1q3wvzd1vi";
      };

      propagatedBuildInputs = with pythonPackages; [
        prettytable
        ipython
        sqlalchemy
        sqlparse
        six
        ipython_genutils
      ];

      doCheck = false;

      meta = with pkgs.stdenv.lib; {
        description = "Introduces a %sql (or %%sql) magic.";
        longDescription = ''
          Introduces a %sql (or %%sql) magic.
          Connect to a database, using SQLAlchemy connect strings, then issue SQL
          commands within IPython or IPython Notebook.
          '';
        homepage = "https://pypi.org/project/ipython-sql/";
        license = licenses.mit;
        maintainers = with maintainers; [ ];
      };
    };
  };

in

{
  python3 = pkgs.python3.override (old: {
    packageOverrides =
      pkgs.lib.composeExtensions
        (old.packageOverrides or (_: _: {}))
        packageOverrides;
  });
}
