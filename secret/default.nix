{ ... }:
{
  # Password used for root user.
  hashedPassword = "$y$j9T$oqCB16i5E2t1t/HAWaFd5.$tTaHtAcifXaDVpTcRv.yH2/eWKxKE9xM8KcqXHfHrD7"; # Use `mkpasswd -s`.

  ssh = {
    # Keys that are allowed to connect via SSH.
    trustedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJTI4IUkHH0JSzWDKOAMbzEDbyBXOrmTHRy+tpqJ8twx nix-on-droid@nothing2"
      (builtins.readFile ./Ssh.key)
    ];

    # Keys that are allowd to connect via SSH to nixbuild user for Nix remote builds.
    builderKey = "nixbuilder-1:Skghjixd8lPzNe2ZEgYLM9Pu/wF9wiZtZGsdm3bo9h0=";
    buildKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuuw5ek5wGB9KdBhCTxjV+CBpPU6RIOynHkFYC4dau3 root@dasha"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGIf192IxsksM6u8UY+eqpHopebgV+NNq2G03ssdXIgz root@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJSWdbkYsRiDlKu8iT/k+JN4KY08iX9qh4VyqxlpEZcE root@home"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFgiYKFkMfiGOZCZIk+O7LtaoF6A3cHEFCqaPwXOM4rR root@work"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPnQ9axOX01pq4EANGOR+5+MMm+pV9GpAAKPc5+fnoBQ root@laptop"
    ];
  };

  crypto = {
    # Git commit signing.
    sign.git = {
      format = "ssh";
      key = ./Ssh.key;
      allowed = ./Signers.key;
    };

    # List of accepted public keys.
    publicKeys = [
      {
        source = ./Gpg.key;
        trust = 5;
      }
    ];
  };
}
