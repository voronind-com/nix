{ self, ... }:
{
  # Tag a build version.
  environment.etc.os-build.text = toString self.lastModified;
}
