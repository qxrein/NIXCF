{ pkgs,  ... }:

{
  environment.systemPackages = with pkgs; [
    # ols
    marksman
    metals
    markdown-oxide
    gopls 
    haskell-language-server
    nil
    ocamlPackages.ocaml-lsp
    typescript-language-server
    vhdl-ls
    # zls
  ];
}
