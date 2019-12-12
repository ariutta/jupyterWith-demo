_: pkgs:
let
  packageOverrides = selfPythonPackages: pythonPackages: {
    jupyterlab_sql = pythonPackages.callPackage ./jupyterlab-sql/default.nix {};
    ipython_sql = pythonPackages.callPackage ./ipython-sql/default.nix {};
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
