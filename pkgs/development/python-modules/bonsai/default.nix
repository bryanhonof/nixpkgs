{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools,
  cyrus_sasl,
  openldap,
  gevent,
  tornado,
  trio,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "bonsai";
  version = "1.5.3";

  disabled = pythonOlder "3.8";

  pyproject = true;

  src = fetchFromGitHub {
    owner = "noirello";
    repo = "bonsai";
    tag = "v${version}";
    hash = "sha256-SAP/YeWqow5dqXlXDzjnTWIfJhMwVeZSSUfWr1Mgmng=";
  };

  build-system = [ setuptools ];

  buildInputs = [
    cyrus_sasl
    openldap
  ];

  optional-dependencies = {
    gevent = [ gevent ];
    tornado = [ tornado ];
    trio = [ trio ];
  };

  nativeCheckInputs = [ pytestCheckHook ];

  disabledTestPaths = [
    # requires running LDAP server
    "tests/test_asyncio.py"
    "tests/test_ldapclient.py"
    "tests/test_ldapconnection.py"
    "tests/test_ldapentry.py"
    "tests/test_ldapreference.py"
    "tests/test_pool.py"
  ];

  disabledTests = [
    # requires running LDAP server
    "test_set_async_connect"
  ];

  pythonImportsCheck = [ "bonsai" ];

  meta = {
    changelog = "https://github.com/noirello/bonsai/blob/${src.rev}/CHANGELOG.rst";
    description = "Python 3 module for accessing LDAP directory servers";
    homepage = "https://github.com/noirello/bonsai";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ dotlambda ];
  };
}
