{
	util,
	...
} @args: {
	text = util.catFile (util.ls ./module) args;
}
