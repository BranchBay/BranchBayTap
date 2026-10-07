{
  description = "BranchBay, a native Git client";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      forEach = f: nixpkgs.lib.genAttrs systems (system: f system);

      # One file per channel, rewritten on every release: the version and,
      # per system, the file on the release host with its hash.
      channel = name: builtins.fromJSON (builtins.readFile (./nix + "/${name}.json"));

      package = system: release:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          lib = pkgs.lib;
          source = release.systems.${system} or (throw "BranchBay ${release.version} has no build for ${system}");
          runtimeLibraries = with pkgs; [ wayland vulkan-loader libxkbcommon xorg.libxcb xorg.libX11 ];
        in
        pkgs.stdenv.mkDerivation {
          pname = "branchbay";
          inherit (release) version;
          src = pkgs.fetchurl { inherit (source) url hash; };

          nativeBuildInputs = lib.optionals pkgs.stdenv.isLinux [ pkgs.autoPatchelfHook pkgs.makeWrapper ]
            ++ lib.optionals pkgs.stdenv.isDarwin [ pkgs.unzip ];
          buildInputs = lib.optionals pkgs.stdenv.isLinux [ pkgs.libxkbcommon pkgs.xorg.libxcb pkgs.zlib pkgs.stdenv.cc.cc.lib ];

          # The zip holds the app bundle; unpacking it by hand keeps the
          # signature intact.
          unpackPhase = if pkgs.stdenv.isDarwin then "unzip -q $src" else null;
          sourceRoot = if pkgs.stdenv.isDarwin then "." else null;

          installPhase =
            if pkgs.stdenv.isDarwin then ''
              mkdir -p $out/Applications $out/bin
              cp -R BranchBay.app $out/Applications/
              ln -s $out/Applications/BranchBay.app/Contents/MacOS/branch-bay $out/bin/branch-bay
            '' else ''
              install -Dm755 branch-bay $out/bin/branch-bay
              install -Dm644 branch-bay.desktop $out/share/applications/branch-bay.desktop
              mkdir -p $out/share/icons
              cp -r icons/hicolor $out/share/icons/
              # Wayland and Vulkan are opened at run time rather than linked.
              wrapProgram $out/bin/branch-bay --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibraries}
            '';

          meta = {
            description = "Native Git client";
            homepage = "https://branchbay.dev";
            license = lib.licenses.unfree;
            platforms = systems;
            mainProgram = "branch-bay";
          };
        };
    in
    {
      packages = forEach (system:
        let
          stable = if builtins.pathExists ./nix/stable.json then { branchbay = package system (channel "stable"); } else { };
          beta = if builtins.pathExists ./nix/beta.json then { branchbay-beta = package system (channel "beta"); } else { };
          all = stable // beta;
        in
        all // { default = all.branchbay or all.branchbay-beta; });
    };
}
