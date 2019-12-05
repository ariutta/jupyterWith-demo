{ stdenv, python3 }:

let
  inherit (python3.pkgs) buildPythonPackage fetchPypi;
in

buildPythonPackage rec {
  pname = "jupyterlab_sql";
  version = "0.3.1";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0ws0swc6kag52924zkgdd514asn53bpif3v327134bn1a56r24k8";
  };

  buildInputs = with python3.pkgs; [
    pytest
  ];

  propagatedBuildInputs = with python3.pkgs; [
    jupyterlab
    sqlalchemy
    jsonschema
  ];

  meta = with stdenv.lib; {
    description = "SQL GUI for JupyterLab.";
    homepage = "https://github.com/pbugnion/jupyterlab-sql";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
