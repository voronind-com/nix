{ ... }:
{
  text = ''
    # Install on a Nintendo Switch.
    # Usage: switch_install <FILES>
    function switch_install() {
      local IFS=$'\n'
      local targets=(''${@})
      [[ "''${targets}" = "" ]] && targets=(*.ns[pz])

      local id=$(_switch_id)
      _switch_mount

      install() {
        gio copy -p "''${target}" ''${id}5:\ SD\ Card\ install/
      }

      _iterate_targets install ''${targets[@]}
    }

    # Backup a Nintendo Switch saves and album.
    function switch_backup() {
      local id=$(_switch_id)
      _switch_mount
      mkdir switch_backup || rm -r switch_backup/*
      mkdir switch_backup/{save,album}
      pushd switch_backup/save
      cp -r /run/user/''${UID}/gvfs/mtp\:host\=-_DBI_*/7\:\ Saves/* .
      popd
      pushd switch_backup/album
      cp -r /run/user/''${UID}/gvfs/mtp\:host\=-_DBI_*/8\:\ Album/* .
      popd
      pushd switch_backup
      archive_fast album
      archive save
    }

    function _switch_id() {
      gio mount -l -i | rg 'mtp://-_DBI_' | sed "s/^.*=//" | head -1
    }

    function _switch_mount() {
      test -d /run/user/''${UID}/gvfs/mtp\:host\=-_DBI_* || gio mount "$(_switch_id)"
    }
  '';
}
