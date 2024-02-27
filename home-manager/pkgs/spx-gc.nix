{ lib, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "spx-gc";
  version = "1.1.2";

  src = fetchFromGitHub {
    owner = "TuomoKu";
    repo = "SPX-GC";
    rev = "v.${version}";
    hash = "sha256-NVppqlQOpOmBtsoDVhaIiHzc360ek273rpr2i9p8WK8=";
  };

  dontNpmBuild = true;

  npmDepsHash = "sha256-TGiurf/vwGV1KBxQXl0gVDNeZZWrW1Yku3fhTmh3nhk=";

  postInstall = ''
    mkdir -p $out/locales
    cp -r $src/locales/* $out/locales
  '';

  meta = with lib; {
    description =
      "SPX is a graphics control client for live video productions and live streams using CasparCG, OBS, vMix, or similar software";
    homepage = "https://github.com/TuomoKu/SPX-GC#npminstall";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    mainProgram = "spx";
  };
}
