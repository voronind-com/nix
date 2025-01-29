{
  buildGoModule,
  fetchFromGitHub,
  lib,
}:
buildGoModule rec {
  name = "ctags-lsp";
  version = "0.6.1";
  vendorHash = null;
  src = fetchFromGitHub {
    owner = "netmute";
    repo = "ctags-lsp";
    tag = "v${version}";
    hash = "sha256-wSccfhVp1PDn/gj46r8BNskEuBuRIx1wydYAW1PV4cg=";
  };

  meta = with lib; {
    description = "LSP implementation using universal-ctags as backend";
    homepage = "https://github.com/netmute/ctags-lsp";
    license = licenses.mit;
    mainProgram = "ctags-lsp";
    maintainers = with maintainers; [ voronind ];
  };
}
