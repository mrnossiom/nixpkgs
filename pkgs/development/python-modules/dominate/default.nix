{ lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "dominate";
  version = "2.9.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-sVeR6+pDIhhUOhcC12rkXS/5X/mU5SAUuGhqadrXcv0=";
  };

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "dominate"
  ];

  meta = with lib; {
    description = "Library for creating and manipulating HTML documents using an elegant DOM API";
    homepage = "https://github.com/Knio/dominate/";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ ];
  };
}
