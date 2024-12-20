{ __findFile, pkgs, ... }:
let
  wm2fc = pkgs.callPackage <package/wm2fc> { };
in
{
  # hardware.cpu.amd.ryzen-smu.enable = true;

  environment.systemPackages = with pkgs; [
    # SRC: https://github.com/FlyGoat/RyzenAdj
    # ./ryzenadj --stapm-limit=45000 --fast-limit=45000 --slow-limit=45000 --tctl-temp=90
    # ryzenAdj --info
    # radg [TEMP]
    ryzenadj

    # SRC: https://github.com/nbfc-linux/nbfc-linux
    nbfc-linux

    wm2fc
  ];

  systemd.services.radj = {
    enable = true;
    description = "Ryzen Adj temperature limiter.";
    serviceConfig.Type = "simple";
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [
      coreutils
      ryzenadj
    ];
    script = ''
      ryzenadj --tctl-temp=55
      while true; do
        sleep 60
        ryzenadj --tctl-temp=55 &> /dev/null
      done
    '';
  };

  systemd.services.fan = {
    enable = true;
    description = "The fan control";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStop = "${wm2fc}/bin/wm2fc a";
      Type = "simple";
    };
    path = with pkgs; [
      coreutils
      wm2fc
    ];
    script = ''
      old=-1
      oldtemp=-1
      smooth=0
      while true; do
        temp=$(cat /sys/devices/pci0000\:00/0000\:00\:18.3/hwmon/*/temp1_input)
        value=0

        if   [ $temp -gt 80000 ]
        then value=184
        elif [ $temp -gt 70000 ]
        then value=128
        elif [ $temp -gt 60000 ]
        then value=92
        elif [ $temp -gt 55000 ]
        then value=52
        elif [ $temp -gt 45000 ]
        then value=46
        elif [ $temp -gt 40000 ]
        then value=23
        else value=0
        fi

        if [[ $old != $value ]]; then
          # 30 = 60s smooth. -5 degrees smooth.
          if [[ $value -lt $old ]] && [[ $smooth -lt 30 ]]; then
            if [[ $temp -lt $((oldtemp - 5000)) ]]; then
              smooth=$((smooth+1))
            fi
          else
            old=$value
            oldtemp=$temp
            smooth=0
            wm2fc $value
          fi
        else
          smooth=0
        fi

        sleep 2
      done
    '';
  };

  # security.wrappers.wm2fc = {
  #   source = "${wm2fc}/bin/wm2fc";
  #   owner  = "root";
  #   group  = "root";
  #   setuid = true;
  #   permissions = "u+rx,g+x,o+x";
  # };
}
