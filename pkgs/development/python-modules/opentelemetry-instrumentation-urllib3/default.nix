{
  buildPythonPackage,
  hatchling,
  opentelemetry-api,
  opentelemetry-instrumentation,
  opentelemetry-semantic-conventions,
  opentelemetry-test-utils,
  opentelemetry-util-http,
  wrapt,
  urllib3,
  packaging,
  pytestCheckHook,
  pythonOlder,
  httpretty,
}:

buildPythonPackage {
  inherit (opentelemetry-instrumentation) version src;
  pname = "opentelemetry-instrumentation-urllib3";
  pyproject = true;

  disabled = pythonOlder "3.8";

  sourceRoot = "${opentelemetry-instrumentation.src.name}/instrumentation/opentelemetry-instrumentation-urllib3";

  build-system = [ hatchling ];

  dependencies = [
    opentelemetry-api
    opentelemetry-instrumentation
    opentelemetry-semantic-conventions
    opentelemetry-util-http
    wrapt
    packaging
    urllib3
  ];

  optional-dependencies = {
    instruments = [ urllib3 ];
  };

  nativeCheckInputs = [
    httpretty
    opentelemetry-test-utils
    pytestCheckHook
  ];

  pythonImportsCheck = [ "opentelemetry.instrumentation.urllib3" ];

  meta = opentelemetry-instrumentation.meta // {
    homepage = "https://github.com/open-telemetry/opentelemetry-python-contrib/blob/main/instrumentation/opentelemetry-instrumentation-urllib3";
    description = "This library allows tracing HTTP requests made by the urllib3 library";
  };
}
