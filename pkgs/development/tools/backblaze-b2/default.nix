{ lib, python3Packages, fetchPypi }:

python3Packages.buildPythonApplication rec {
  pname = "backblaze-b2";
  version = "3.7.0";

  src = fetchPypi {
    inherit version;
    pname = "b2";
    sha256 = "sha256-sW6gaZWUh3WX+0+qHRlQ4gZzKU4bL8ePPNKWo9rdF84=";
  };

  postPatch = ''
    substituteInPlace requirements.txt \
      --replace 'phx-class-registry==4.0.5' 'phx-class-registry'
    substituteInPlace requirements.txt \
      --replace 'tabulate==0.8.10' 'tabulate'
    substituteInPlace setup.py \
      --replace 'setuptools_scm<6.0' 'setuptools_scm'
  '';

  nativeBuildInputs = with python3Packages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python3Packages; [
    b2sdk
    phx-class-registry
    setuptools
    docutils
    rst2ansi
    tabulate
  ];

  nativeCheckInputs = with python3Packages; [
    backoff
    more-itertools
    pytestCheckHook
  ];

  preCheck = ''
    export HOME=$(mktemp -d)
  '';

  disabledTests = [
    # require network
    "test_files_headers"
    "test_integration"
  ];

  disabledTestPaths = [
    # requires network
    "test/integration/test_b2_command_line.py"
  ];

  postInstall = ''
    mv "$out/bin/b2" "$out/bin/backblaze-b2"

    sed 's/b2/backblaze-b2/' -i contrib/bash_completion/b2

    mkdir -p "$out/share/bash-completion/completions"
    cp contrib/bash_completion/b2 "$out/share/bash-completion/completions/backblaze-b2"
  '';

  meta = with lib; {
    description = "Command-line tool for accessing the Backblaze B2 storage service";
    homepage = "https://github.com/Backblaze/B2_Command_Line_Tool";
    changelog = "https://github.com/Backblaze/B2_Command_Line_Tool/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ hrdinka kevincox tomhoule ];
  };
}
