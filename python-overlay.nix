_: pkgs:
let
  packageOverrides = selfPythonPackages: pythonPackages: {
    jupyterlab_sql = pythonPackages.callPackage ./nixpkgs/jupyterlab-sql/default.nix {};
    ipython_sql = pythonPackages.callPackage ./nixpkgs/ipython-sql/default.nix {};
    nb_black = pythonPackages.callPackage ./nixpkgs/nb_black/default.nix {};
    jupyter_bokeh = pythonPackages.callPackage ./nixpkgs/jupyter_bokeh/default.nix {};
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
