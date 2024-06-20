{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonRelaxDepsHook,
  asn1crypto,
  astunparse,
  bincopy,
  bitstring,
  click,
  click-command-tree,
  click-option-group,
  colorama,
  crcmod,
  cryptography,
  deepmerge,
  fastjsonschema,
  hexdump,
  libusbsio,
  oscrypto,
  packaging,
  platformdirs,
  prettytable,
  pyocd,
  pyserial,
  requests,
  ruamel-yaml,
  setuptools,
  setuptools-scm,
  sly,
  spsdk,
  testers,
  typing-extensions,
  ipykernel,
  pytest-notebook,
  pytestCheckHook,
  voluptuous,
}:

buildPythonPackage rec {
  pname = "spsdk";
  version = "2.2.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "nxp-mcuxpresso";
    repo = "spsdk";
    rev = "refs/tags/${version}";
    hash = "sha256-2CFxJAP87ysly0i4AfODbwUt5W287+OK7fatdPco7e4=";
  };

  nativeBuildInputs = [
    pythonRelaxDepsHook
    setuptools
    setuptools-scm
  ];

  pythonRelaxDeps = [
    "click"
    "cryptography"
    "platformdirs"
    "requests"
    "typing-extensions"
  ];

  # Remove unneeded unfree package. pyocd-pemicro is only used when
  # generating a pyinstaller package, which we don't do.
  postPatch = ''
    substituteInPlace ./requirements.txt \
      --replace "pyocd-pemicro<1.2,>=1.1.5" ""
  '';

  propagatedBuildInputs = [
    asn1crypto
    astunparse
    bincopy
    bitstring
    click
    click-command-tree
    click-option-group
    colorama
    crcmod
    cryptography
    deepmerge
    fastjsonschema
    hexdump
    libusbsio
    oscrypto
    packaging
    platformdirs
    prettytable
    pyocd
    pyserial
    requests
    ruamel-yaml
    sly
    typing-extensions
  ];

  nativeCheckInputs = [
    ipykernel
    pytest-notebook
    pytestCheckHook
    voluptuous
  ];

  disabledTests = [
    "test_nxpcrypto_create_signature_algorithm"
    "test_nxpimage_sb31_kaypair_not_matching"
  ];

  pythonImportsCheck = [ "spsdk" ];

  passthru.tests.version = testers.testVersion { package = spsdk; };

  meta = with lib; {
    changelog = "https://github.com/nxp-mcuxpresso/spsdk/blob/${src.rev}/docs/release_notes.rst";
    description = "NXP Secure Provisioning SDK";
    homepage = "https://github.com/nxp-mcuxpresso/spsdk";
    license = licenses.bsd3;
    maintainers = with maintainers; [
      frogamic
      sbruder
    ];
    mainProgram = "spsdk";
  };
}
