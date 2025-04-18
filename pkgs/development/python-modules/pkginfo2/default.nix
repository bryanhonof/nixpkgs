{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pytestCheckHook,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "pkginfo2";
  version = "30.0.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "nexB";
    repo = "pkginfo2";
    tag = "v${version}";
    hash = "sha256-E9EyaN3ncf/34vvvhRe0rwV28VrjqJo79YFgXq2lKWU=";
  };

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "pkginfo2" ];

  meta = with lib; {
    description = "Query metadatdata from sdists, bdists or installed packages";
    mainProgram = "pkginfo2";
    homepage = "https://github.com/nexB/pkginfo2";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
