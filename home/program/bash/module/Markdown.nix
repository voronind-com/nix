{ ... }:
{
  text = ''
    # Render markdown in browser using Gitea API. Because I want consistency with Gitea web render.
    # Works only inside LAN.
    # Usage: markdown_render <FILE.md>
    function markdown_render() {
      local IFS=$'\n'
      local file="''${1}"
      local render="markdown_render.html"

      if [[ "''${file}" = "" ]]; then
        help markdown_render
        return 2
      fi

      curl -X POST https://git.voronind.com/markdown -d "$(cat ''${file})" > "''${render}" && o "''${render}" && sleep 2 && rm "''${render}"
    }
  '';
}
