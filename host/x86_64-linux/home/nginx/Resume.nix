{ ... }:
{
  "resume.voronind.com".extraConfig = ''
    server_name resume.voronind.com;
    listen 443 ssl;

    ssl_certificate /etc/letsencrypt/live/voronind.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/voronind.com/privkey.pem;
    include /etc/letsencrypt/conf/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/conf/ssl-dhparams.pem;

    if ($http_accept_language ~ ru) {
      return 301 https://git.voronind.com/voronind/resume/releases/download/latest/VoronindRu.pdf;
    }

    return 301 https://git.voronind.com/voronind/resume/releases/download/latest/VoronindEn.pdf;
  '';
}
