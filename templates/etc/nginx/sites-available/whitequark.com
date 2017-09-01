server {
  server_name {{name}};
  listen [::]:80;
{% if has_tls %}
  listen [::]:443 ssl;
  include ssl_params;
  ssl_certificate /etc/letsencrypt/live/{{name}}/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/{{name}}/privkey.pem;
{% endif %}

  root /var/www/{{name}};
  index index.html;

  rewrite ^/$ https://whitequark.org/ permanent;
}