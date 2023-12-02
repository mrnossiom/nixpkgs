{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, setuptools
, setuptools-scm
, pythonRelaxDepsHook
, pyasn1
, pyasn1-modules
, cryptography
, joblib
, gitpython
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "edk2-pytool-library";
  version = "0.19.6";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "tianocore";
    repo = "edk2-pytool-library";
    rev = "v${version}";
    hash = "sha256-T4DVidz4Xu4M+G7CzrUxRQPotg8ciwCQfa95e0IgpkM=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "tinydb"
    "joblib"
  ];

  propagatedBuildInputs = [
    pyasn1
    pyasn1-modules
    cryptography
    joblib
    gitpython
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  disabledTests = [
    # requires network access
    "test_basic_parse"
  ];

  pythonImportsCheck = [ "edk2toollib" ];

  meta = with lib; {
    description = "Python library package that supports UEFI development";
    homepage = "https://github.com/tianocore/edk2-pytool-library";
    changelog = "https://github.com/tianocore/edk2-pytool-library/releases/tag/v${version}";
    license = licenses.bsd2Patent;
    maintainers = with maintainers; [ nickcao ];
    platforms = platforms.linux;
  };
}
