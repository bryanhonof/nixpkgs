{
  buildPythonPackage,
  hatchling,
  opentelemetry-sdk,
  opentelemetry-instrumentation,
  opentelemetry-test-utils,
  packaging,
  pytestCheckHook,
  pythonOlder,
}:

buildPythonPackage {
  inherit (opentelemetry-instrumentation) version src;
  pname = "opentelemetry-resource-detector-azure";
  pyproject = true;

  disabled = pythonOlder "3.9";

  sourceRoot = "${opentelemetry-instrumentation.src.name}/resource/opentelemetry-resource-detector-azure";

  build-system = [ hatchling ];

  dependencies = [
    opentelemetry-sdk
    opentelemetry-instrumentation
    packaging
  ];

  nativeCheckInputs = [
    opentelemetry-test-utils
    pytestCheckHook
  ];

  pythonImportsCheck = [ "opentelemetry.resource.detector.azure.app_service" ];

  meta = opentelemetry-instrumentation.meta // {
    homepage = "https://github.com/open-telemetry/opentelemetry-python-contrib/tree/main/resource/opentelemetry-resource-detector-azure";
    description = "Azure Resource Detector for OpenTelemetry";
  };
}
