{
  lib,
  azure-cli,
  buildPythonPackage,
  fetchPypi,
  setuptools,

  azure-core,
  opentelemetry-api,
}:

buildPythonPackage rec {
  pname = "azure-core-tracing-opentelemetry";
  version = "1.0.0b12";

  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "azure_core_tracing_opentelemetry";
    hash = "sha256-u0VBQkQLrhH9nWjHwdZ644oXVs6AjF5Nc2cwp7SwQUQ=";
  };

  build-system = [ setuptools ];

  dependencies = [
    azure-core
    opentelemetry-api
  ];

  pythonImportsCheck = [
    "azure"
    "opentelemetry"
  ];

  meta = {
    changelog = "https://github.com/Azure/azure-sdk-for-python/blob/azure-core-tracing-opentelemetry_${version}/sdk/core/azure-core-tracing-opentelemetry/CHANGELOG.md";
    description = "Azure Core Tracing OpenTelemetry client library for Python";
    homepage = "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/core/azure-core-tracing-opentelemetry";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bryanhonof ];
  };
}
