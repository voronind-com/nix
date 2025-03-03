{ ... }:
{
  services.privatebin = {
    enable = true;
    enableNginx = true;
    virtualHost = "paste.voronind.com";
    settings = {
      main = {
        compression = "none";
        defaultformatter = "plaintext";
        discussion = false;
        email = true;
        fileupload = false;
        languageselection = false;
        name = "voronind pastebin";
        password = true;
        qrcode = true;
        sizelimit = 10 * 1000 * 1000;
        template = "bootstrap";
      };
      expire = {
        default = "1week";
      };
      formatter_options = {
        markdown = "Markdown";
        plaintext = "Plain Text";
        syntaxhighlighting = "Source Code";
      };
      traffic = {
        limit = 10;
      };
      purge = {
        limit = 0;
        batchsize = 10;
      };
      # model = {
      #   class = "Database";
      # };
      # model_options = {
      #   "opt[12]" = true;
      #   dsn = "pgsql:dbname=privatebin";
      #   pwd = "privatebin";
      #   tbl = "privatebin_";
      #   usr = "privatebin";
      # };
    };
  };
}
