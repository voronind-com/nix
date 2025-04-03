{ secret, ... }:
{
  users.users.root.openssh.authorizedKeys.keys = [ secret.network.host.desktop.key ];
}
