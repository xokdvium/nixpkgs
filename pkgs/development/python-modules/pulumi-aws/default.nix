{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  parver,
  pulumi,
  pythonOlder,
  semver,
  setuptools,
}:

buildPythonPackage rec {
  pname = "pulumi-aws";
  # Version is independant of pulumi's.
  version = "6.49.1";

  pyproject = true;
  build-system = [ setuptools ];

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "pulumi";
    repo = "pulumi-aws";
    rev = "refs/tags/v${version}";
    hash = "sha256-THgLOVCr+LWNO1SCGUrh8L/I75d2RSNw84FcovCSsBM=";
  };

  sourceRoot = "${src.name}/sdk/python";

  propagatedBuildInputs = [
    parver
    pulumi
    semver
  ];

  # Checks require cloud resources
  doCheck = false;

  pythonImportsCheck = [ "pulumi_aws" ];

  meta = with lib; {
    description = "Pulumi python amazon web services provider";
    homepage = "https://github.com/pulumi/pulumi-aws";
    changelog = "https://github.com/pulumi/pulumi-aws/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
