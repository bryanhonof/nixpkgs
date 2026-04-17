{
  lib,
  azure-cli,
  buildPythonPackage,
  fetchPypi,
  setuptools,

  azure-core,
  azure-identity,
  msrest,
  opentelemetry-api,
  opentelemetry-sdk,
  psutil,
}:

buildPythonPackage rec {
  pname = "azure-monitor-opentelemetry-exporter";
  version = "1.0.0b51";

  pyproject = true;

  src = fetchPypi {
    inherit version;
    pname = "azure_monitor_opentelemetry_exporter";
    hash = "sha256-phccNDJrzWIWk4u0DXFcFfHyKYSsGYb8lyMTNtisTDw=";
  };

  build-system = [ setuptools ];

  pythonRelaxDeps = [ "azure-identity" ];

  dependencies = [
    azure-core
    azure-identity
    msrest
    opentelemetry-api
    opentelemetry-sdk
    psutil
  ];

  pythonImportsCheck = [
    "azure"
    "azure.monitor.opentelemetry.exporter"
  ];

  meta = {
    changelog = "https://github.com/Azure/azure-sdk-for-python/blob/azure-monitor-opentelemetry-exporter_${version}/sdk/monitor/azure-monitor-opentelemetry-exporter/CHANGELOG.md";
    description = "The exporter for Azure Monitor allows Python applications to export data from the OpenTelemetry SDK to Azure Monitor";
    homepage = "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/monitor/azure-monitor-opentelemetry-exporter";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ bryanhonof ];
  };
}
