{ pkgs, ... }:
let
  my-vscode = pkgs.vscode.overrideAttrs (old: {
    postInstall = ''
      sed -i '/*inject*/ a @import "custom.css";' $out/lib/vscode/resources/app/out/vs/workbench/workbench.desktop.main.css
    '';
  });
in
{
  environment.systemPackages = [ my-vscode ];
}

