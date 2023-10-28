{ pkgs, lib, ... }:

let nixgl = import <nixgl> { };
in pkg:
pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
  mkdir $out
  ln -s ${pkg}/* $out
  rm $out/bin
  mkdir $out/bin
  for bin in ${pkg}/bin/*; do
  wrapped_bin=$out/bin/$(basename $bin)
  echo -e "#!/bin/bash\nexec ${
    lib.getExe nixgl.auto.nixGLDefault
  } $bin \$@" > $wrapped_bin
  chmod +x $wrapped_bin
  done
''
