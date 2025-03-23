{ config, ... }:
let
  userChrome = ''
    * {
      font-family: "${config.module.style.font.serif.name}" !important;
      font-size:   ${toString config.module.style.font.size.application}pt !important;
    }
  '';

  userContent = ''
    @-moz-document url(about:home), url(about:newtab), url(about:privatebrowsing), url(about:blank) {
      .click-target-container *, .top-sites-list * {
        color: #fff !important ;
        text-shadow: 2px 2px 2px #222 !important ;
      }
      body::before {
        content: "" ;
        z-index: -1 ;
        position: fixed ;
        top: 0 ;
        left: 0 ;
        background: #f9a no-repeat url("${config.module.wallpaper.path}?raw=true") center ;
        background-color: #222;
        background-size: cover ;
        /* filter: blur(4px) ; */
        width: 100vw ;
        height: 100vh ;
      }
      /* .logo { background-image: url("{repo}/logo.png?raw=true") !important; } */
      /* .logo { background-image: none !important; } */
      }
  '';
in
{
  profiles.default = { inherit userChrome userContent; };
}
