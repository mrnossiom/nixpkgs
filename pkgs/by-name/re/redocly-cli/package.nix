{ lib
, buildNpmPackage
, fetchFromGitHub
, makeWrapper
}:

buildNpmPackage rec {
  pname = "redocly-cli";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "Redocly";
    repo = "redocly-cli";
    rev = "@redocly/cli@${version}";
    hash = "sha256-Wi3IxPeNqD1s1Q0Pi9cCus6jCQM0noBTHIAp9HUSpZk=";
  };

  npmDepsHash = "sha256-BcjQ9z2i1YBt6lBqgkRcv29P/WZeuGjVSeVmekaFugM=";

  npmBuildScript = "prepare";

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    rm $out/lib/node_modules/@redocly/cli/node_modules/@redocly/{cli,openapi-core}
    cp -R packages/cli $out/lib/node_modules/@redocly/cli/node_modules/@redocly/cli
    cp -R packages/core $out/lib/node_modules/@redocly/cli/node_modules/@redocly/openapi-core

    mkdir $out/bin
    makeWrapper $out/lib/node_modules/@redocly/cli/node_modules/@redocly/cli/bin/cli.js $out/bin/redocly-cli --set REDOCLY_TELEMETRY off
  '';

  installCheckPhase = ''
    runHook preInstallCheck
    $out/bin/redocly-cli --version
    runHook postInstallCheck
  '';

  doInstallCheck = true;

  meta = {
    description = "Redocly CLI makes OpenAPI easy. Lint/validate to any standard, generate beautiful docs, and more.";
    homepage = "https://github.com/Redocly/redocly-cli";
    license = lib.licenses.mit;
    mainProgram = "redocly-cli";
    maintainers = with lib.maintainers; [ szlend ];
  };
}
