{ stdenv, python3 }:

let
  inherit (python3.pkgs) buildPythonPackage fetchPypi;
in

buildPythonPackage rec {
  pname = "jupyter_bokeh";
  version = "1.1.1";
  name = "${pname}-${version}";

  src = fetchPypi {
    inherit pname version;
    sha256 = "12q78jmf5s6fn6dxsxsih9ar1djg2kzg617jj6hvihr7i7a8vqx2";
  };

  propagatedBuildInputs = with python3.pkgs; [
    bokeh
    ipython
    ipywidgets
  ];

  meta = with stdenv.lib; {
    description = "An extension for rendering Bokeh content in JupyterLab notebooks.";
    homepage = "https://github.com/bokeh/jupyter_bokeh";
    license = licenses.bsd3;
    maintainers = with maintainers; [ ];
  };
}
