{ ... }: {
	boot.kernelParams = [
		"fbcon=rotate:1"
		"video=DSI-1:rotate=90"
	];
}
