{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  fetchPypi,

  azure-core,
  azure-mgmt-core,
  azure-common,
  azure-storage-blob,
  azure-storage-file-share,
  azure-storage-file-datalake,
  azure-monitor-opentelemetry,

  pyyaml,
  marshmallow,
  packaging,
  jsonschema,
  tqdm,
  strictyaml,
  colorama,
  pyjwt,
  pydash,
  isodate,
  typing-extensions,

  # TODO(bryanhonof): Package these "optional" dependencies
  # mldesigner,
  # azureml-dataprep-rslex,

  flit-core,
  pythonOlder,
  setuptools,
}:

let
  marshmallow_3 = buildPythonPackage {
    pname = "marshmallow";
    version = "3.26.1";
    pyproject = true;

    src = fetchFromGitHub {
      owner = "marshmallow-code";
      repo = "marshmallow";
      tag = "3.26.1";
      hash = "sha256-l5pEhv8D6jRlU24SlsGQEkXda/b7KUdP9mAqrZCbl38=";
    };

    build-system = [ flit-core ];
    dependencies = [ packaging ];

    # Upstream's full test matrix drags in optional deps that are not needed by azure-ai-ml.
    doCheck = false;

    pythonImportsCheck = [ "marshmallow" ];
  };
in
buildPythonPackage rec {
  pname = "azure-ai-ml";
  version = "1.28.1";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit version;
    pname = "azure_ai_ml";
    hash = "sha256-qkRjjQM+ZDk8OVL1mnOCLx0/iTBXvQ8ZV/gR1+algDY=";
  };

  build-system = [ setuptools ];

  dependencies = [
    azure-core
    azure-mgmt-core
    azure-common
    azure-storage-blob
    azure-storage-file-share
    azure-storage-file-datalake
    azure-monitor-opentelemetry

    pyyaml
    marshmallow_3
    jsonschema
    tqdm
    strictyaml
    colorama
    pyjwt
    pydash
    isodate
    typing-extensions
  ];

  # TODO(bryanhonof): Uncomment when the optional dependencies are packaged
  #
  # optional-dependencies = {
  #   designer = [
  #     mldesigner
  #   ];
  # }
  # // lib.optionalAttrs (pythonOlder "3.13") {
  #   mount = [
  #     azureml-dataprep-rslex
  #   ];
  # };

  pythonNamespaces = [ "azure.ai" ];

  pythonImportsCheck = [ "azure.ai.ml" ];

  meta = with lib; {
    description = "Azure ML Package client library for Python";
    homepage = "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/ai/azure-ai-ml";
    changelog = "https://github.com/Azure/azure-sdk-for-python/blob/azure-ai-ml_${version}/sdk/resources/azure-ai-ml/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [
      bryanhonof
    ];
  };
}
