{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, setuptools
, pyyaml
}:

buildPythonPackage rec {
  pname = "pyngrok";
  version = "7.0.3";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-RNi0ivQKsLb/JD9+vdJYGf5HDC6BmeNdseR2OU8v1uY=";
  };

  nativeBuildInputs = [
    setuptools
  ];

  propagatedBuildInputs = [
    pyyaml
  ];

  pythonImportsCheck = [ "pyngrok" ];

  meta = with lib; {
    description = "A Python wrapper for ngrok";
    homepage = "https://github.com/alexdlaird/pyngrok";
    changelog = "https://github.com/alexdlaird/pyngrok/blob/${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ wegank ];
  };
}
