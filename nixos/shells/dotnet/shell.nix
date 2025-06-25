{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
	buildInputs = [
		pkgs.dotnet-sdk
	];

	nativeBuildInputs = [
	];

	shellHook = ''
	export MY_ENV_VAR="Hello, Nix!"
	echo "Welcome to the Nix shell!"
	'';

	shellPrompt = "nix-shell> ";

	userEnvPkgs = [
		pkgs.fish
	];
}

