{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "docker-craft-cms-dev-env";
  version = "unstable-2023-04-14";

  src = fetchFromGitHub {
    owner = "codemonauts";
    repo = "docker-craft-cms-dev-env";
    rev = "5053d61654bc720fd61e011642e925a99d81baa0";
    hash = "sha256-VNL/cyECDx0FSn2xMHMQDbJ3d0y7SEKPZ2EzotQy/PA=";
  };

  postInstall = ''
    mkdir -p $out/bin
    cp -r $src/bin/craft $out/bin/craft
  '';

  meta = with lib; {
    description =
      "Docker image for local development of sites based on Craft CMS";
    homepage = "https://github.com/codemonauts/docker-craft-cms-dev-env";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
