{
  lib,
  buildPythonPackage,
  fetchPypi,
  msrest,
  msrestazure,
  azure-common,
  azure-mgmt-core,
  azure-mgmt-nspkg,
  isPy3k,
}:

buildPythonPackage rec {
  pname = "azure-mgmt-resourcegraph";
  version = "8.0.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    hash = "sha256-0l8B2uOJd4D7PdyhbRYltjR8MvG1gcdn+6XvOyREPxE=";
  };

  propagatedBuildInputs = [
    msrest
    msrestazure
    azure-common
    azure-mgmt-core
  ];

  meta = with lib; {
    description = "This is the Microsoft Azure Resource Graph Client Library";
    homepage = "https://github.com/Azure/azure-sdk-for-python";
    license = licenses.mit;
    maintainers = with maintainers; [ bryanhonof ];
  };
}
