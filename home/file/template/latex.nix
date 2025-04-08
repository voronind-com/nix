{
  description = "LuaLaTeX build env.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }@inputs:
    let
      inherit (nixpkgs) lib;
      pkgs = nixpkgs.legacyPackages.${system};
      system = "x86_64-linux";
      tex = pkgs.texlive.combine {
        inherit (pkgs.texlive)
          amsmath
          babel
          capt-of
          catchfile
          collection-fontsextra
          cyrillic
          dvipng
          dvisvgm
          environ
          etoolbox
          fancyhdr
          fontspec
          geometry
          hyperref
          listofitems
          luacode
          luatexbase
          montserrat
          parskip
          pgf
          scheme-basic
          tcolorbox
          tocloft
          ulem
          wrapfig
          xcolor
          ;

        #(setq org-latex-compiler "lualatex")
        #(setq org-preview-latex-default-process 'dvisvgm)
      };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell rec {
          nativeBuildInputs = with pkgs; [ tex ];
          buildInputs = with pkgs; [ ];
          SOURCE_DATE_EPOCH = "${toString self.lastModified}";
        };
      };
    };
}
