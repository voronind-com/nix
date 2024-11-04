{
	config,
	...
}: {
	text = ''
		window#waybar {
			background-color: rgba(${config.module.style.color.bg-r},${config.module.style.color.bg-g},${config.module.style.color.bg-b},${toString config.module.style.opacity.desktop});
			border: ${toString config.module.style.window.border}px solid rgba(${config.module.style.color.border-r},${config.module.style.color.border-g},${config.module.style.color.border-b},${toString config.module.style.opacity.desktop});
		}

		.modules-left > widget:first-child > #workspaces {
			margin-left: ${toString config.module.style.window.border}px;
		}

		.modules-right > widget:last-child > #workspaces {
			margin-right: ${toString config.module.style.window.border}px;
		}
	'';
}
