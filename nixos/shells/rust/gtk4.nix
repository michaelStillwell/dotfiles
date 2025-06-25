{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
	buildInputs = [
		pkgs.rustup
		pkgs.gtk4
		pkgs.gdk-pixbuf
		pkgs.graphene
		pkgs.gobject-introspection
		pkgs.pkg-config  # Add pkg-config here
	];

	shellHook = ''
	export PKG_CONFIG_PATH=${pkgs.gtk4}/lib/pkgconfig
	rustup default stable
	'';
}

