{ ... }: {
	"org/gnome/nautilus/icon-view" = {
		default-zoom-level = "larger";
	};

	"org/gnome/nautilus/list-view" = {
		default-zoom-level = "small";
		use-tree-view      = false;
	};

	"org/gnome/nautilus/preferences" = {
		click-policy                  = "single";
		default-folder-viewer         = "list-view";
		default-sort-in-reverse-order = false;
		default-sort-order            = "name";
		migrated-gtk-settings         = true;
		search-filter-time-type       = "last_modified";
		search-view                   = "list-view";
		show-image-thumbnails         = "local-only";
	};
}
