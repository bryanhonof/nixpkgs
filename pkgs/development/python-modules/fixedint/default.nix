{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
}:

buildPythonPackage rec {
  pname = "fixedint";
  version = "0.2.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-ruoMejpU5Tce1jL5qXcZMWaZ9k+GP/zkQU7w+SUlXRc=";
  };

  build-system = [ setuptools ];

  pythonImportsCheck = [ "fixedint" ];

  meta = {
    changelog = "https://github.com/nneonneo/fixedint/releases/tag/${version}";
    homepage = "https://github.com/nneonneo/fixedint/releases/tag";
    description = "Fixed-width integers for Python";
    license = lib.licenses.psfl;
    maintainers = with lib.maintainers; [
      bryanhonof
    ];
  };
}
