{ util, config, ... }@args:
{
  text = util.catText (util.ls ./module) args;
}
