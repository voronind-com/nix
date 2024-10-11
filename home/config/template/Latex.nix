{
  description = "LuaLaTeX build env.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      tex = (
        pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-basic
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
            tcolorbox
            tocloft
            ulem
            wrapfig
            xcolor
            ;

          #(setq org-latex-compiler "lualatex")
          #(setq org-preview-latex-default-process 'dvisvgm)
        }
      );
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell rec {
          nativeBuildInputs = with pkgs; [
            tex
          ];
          buildInputs = with pkgs; [ ];
          SOURCE_DATE_EPOCH = "${toString self.lastModified}";
        };
      };
    };
}
