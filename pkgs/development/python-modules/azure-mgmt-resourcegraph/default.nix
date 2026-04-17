{
  lib,
  buildPythonPackage,
  fetchPypi,
  azure-mgmt-core,
  msrest,
  pythonOlder,
  setuptools,
  typing-extensions,
  wheel,
}:

buildPythonPackage rec {
  pname = "azure-mgmt-resourcegraph";
  version = "8.0.1";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchPypi {
    pname = "azure_mgmt_resourcegraph";
    inherit version;
    hash = "sha256-VaIdZtprKKCA2QPsoZLQL8HP0HdeE5sw1EEXykumrR8=";
  };

  build-system = [
    setuptools
    wheel
  ];

  dependencies = [
    msrest
    azure-mgmt-core
    typing-extensions
  ];

  pythonImportsCheck = [ "azure.mgmt.resourcegraph" ];

  meta = with lib; {
    description = "This is the Microsoft Azure Resource Graph Client Library";
    homepage = "https://github.com/Azure/azure-sdk-for-python";
    license = licenses.mit;
    maintainers = with maintainers; [ bryanhonof ];
  };
}
