{ secret, pkgs, ... }:
{
  config = (pkgs.formats.gitIni { listsAsDuplicateKeys = true; }).generate "git-config" {
    branch.sort = "-committerdate"; # Sort branches by recent commits.
    core.excludesfile = "~/.gitignore"; # Global excludes file.
    init.defaultBranch = "main";
    merge.conflictstyle = "zdiff3"; # Show the original line value with conflicts.
    pull.rebase = true; # Rebase when pulling.
    safe.directory = "*"; # Allow all users to work with all local repos.
    tag.sort = "version:refname"; # Sort tags by time.
    user.signingkey = builtins.readFile secret.crypto.sign.git.key;
    diff = {
      algorithm = "histogram"; # Use histogram algo for better visual comparison.
      colorMoved = "plain"; # Better difference between moved and added code.
      mnemonicPrefix = true; # Use mnemonics.
      renames = true; # Detect file renames.
    };
    fetch = {
      all = true; # Fetch everything.
      prune = true; # Prune stuff that's gone.
      pruneTags = true; # Prune tags that's gone.
    };
    gpg = {
      inherit (secret.crypto.sign.git) format;
      ssh.allowedSignersFile = toString secret.crypto.sign.git.allowed;
    };
    push = {
      autoSetupRemote = true; # Automatically select remote server.
      default = "simple"; # Push to the same name.
      followTags = true; # Always push the tags.
    };
    rebase = {
      autoSquash = true; # Squash commits with "squash! ", "fixup! " or "amend! " in messages
      autoStash = true; # Automatically stash & pop when rebasing.
      updateRefs = true; # Automatically rebase branches that point to rebased commits.
    };
    rerere = {
      enabled = true; # Simplify multiple rebases with conflicts.
      autoupdate = true; # Automatically re-apply the solutions. Use with caution, check the result.
    };
  };
  # NOTE: Can be use useful for big repos.
  # git config core.fsmonitor true
  # git config core.untrackedCache true

  ignore = pkgs.writeText "git-ignore" ''
    /.gc-roots
    /.gc-roots-*
  '';
}
