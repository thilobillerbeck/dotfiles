{ lib, python3Packages }:
with python3Packages;
buildPythonApplication {
  name = "toggl-time-grouper";
  src = ./.;
  propagatedBuildInputs = [ pandas ];
}