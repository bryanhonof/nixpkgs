{
  lib,
  azure-cli,
  buildPythonPackage,
  fetchPypi,
  setuptools,

  azure-core,
  azure-core-tracing-opentelemetry,
  isodate,
  typing-extensions,
  azure-monitor-opentelemetry-exporter,
  opentelemetry-instrumentation-django,
  opentelemetry-instrumentation-fastapi,
  opentelemetry-instrumentation-flask,
  opentelemetry-instrumentation-logging,
  opentelemetry-instrumentation-psycopg2,
  opentelemetry-instrumentation-requests,
  opentelemetry-instrumentation-urllib,
  opentelemetry-instrumentation-urllib3,
  opentelemetry-resource-detector-azure,
  opentelemetry-sdk,
}:

buildPythonPackage rec {
  pname = "azure-monitor-opentelemetry";
  version = "1.8.7";

  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "azure_monitor_opentelemetry";
    hash = "sha256-0KQwxpRR+PoJNidp0tZUcXE5ift45K0PUIMrWXkh77s=";
  };

  build-system = [ setuptools ];

  pythonRelaxDeps = [ "opentelemetry-resource-detector-azure" ];

  dependencies = [
    azure-core
    azure-core-tracing-opentelemetry
    isodate
    typing-extensions
    azure-monitor-opentelemetry-exporter
    opentelemetry-instrumentation-django
    opentelemetry-instrumentation-fastapi
    opentelemetry-instrumentation-flask
    opentelemetry-instrumentation-logging
    opentelemetry-instrumentation-psycopg2
    opentelemetry-instrumentation-requests
    opentelemetry-instrumentation-urllib
    opentelemetry-instrumentation-urllib3
    opentelemetry-resource-detector-azure
    opentelemetry-sdk
  ];

  pythonImportsCheck = [
    "azure"
    # "azure.monitor.opentelemetry"
  ];

  meta = {
    changelog = "https://github.com/Azure/azure-sdk-for-python/blob/azure-monitor-opentelemetry_${version}/sdk/monitor/azure-monitor-opentelemetry/CHANGELOG.md";
    description = "The Azure Monitor Distro of Opentelemetry Python is a one-stop-shop telemetry solution";
    homepage = "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/monitor/azure-monitor-opentelemetry";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bryanhonof ];
  };
}
