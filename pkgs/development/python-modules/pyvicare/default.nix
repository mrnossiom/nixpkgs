{ lib
, authlib
, buildPythonPackage
, fetchFromGitHub
, pkce
, pytestCheckHook
, pythonOlder
, simplejson
}:

buildPythonPackage rec {
  pname = "pyvicare";
  version = "2.29.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "somm15";
    repo = "PyViCare";
    rev = "refs/tags/${version}";
    hash = "sha256-FTvlRCPajRqKLCb5x1Gz/EGZIdMhXow4nP+WlWbjLko=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace "version_config=True," 'version="${version}",' \
      --replace "'setuptools-git-versioning<1.8.0'" ""
  '';

  propagatedBuildInputs = [
    authlib
    pkce
  ];

  nativeCheckInputs = [
    pytestCheckHook
    simplejson
  ];

  pythonImportsCheck = [
    "PyViCare"
  ];

  meta = with lib; {
    description = "Python Library to access Viessmann ViCare API";
    homepage = "https://github.com/somm15/PyViCare";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
  };
}
