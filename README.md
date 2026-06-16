# dendrinix

Den aspects for dendritic NixOS and Home Manager configuration.

## Use

Inspect outputs:

```sh
nix flake show
```

Format Nix files:

```sh
nix fmt
```

Run checks:

```sh
nix flake check
```

Enter the development shell:

```sh
nix develop
```

Regenerate `flake.nix` after editing module definitions:

```sh
nix run .#write-flake
```

## Development notes

- `flake.nix` is generated. Do not edit it manually.
- Formatting is provided by `nixfmt` and `nixfmt-tree`.
- Tests are defined through `nix-unit`.

## 🛠️ Tech Stack

- [NixOS](https://nixos.org/).
- [flake-parts homepage](https://flake.parts/)
  ([flake-parts @ GitHub](https://github.com/hercules-ci/flake-parts)).
- [nix-auto-follow @ GitHub](https://github.com/fzakaria/nix-auto-follow).

### ❄️ Dendritic Nix

- [flake-file homepage](https://flake-file.oeiuwq.com/)
  ([flake-file @ GitHub](https://github.com/vic/flake-file)).
- [import-tree homepage](https://import-tree.oeiuwq.com/)
  ([import-tree @ GitHub](https://github.com/vic/import-tree)).
- [den homepage](https://den.denful.dev/)
  ([den @ GitHub](https://github.com/denful/den)).

### Development tools

- [nixfmt @ GitHub](https://github.com/NixOS/nixfmt).
- [nix-unit homepage](https://nix-community.github.io/nix-unit/)
  ([nix-unit @ GitHub](https://github.com/nix-community/nix-unit)).
- [devshell homepage](https://numtide.github.io/devshell/)
  ([devshell @ GitHub](https://github.com/numtide/devshell)).

## 📝 Documentation

- [Dendrix](https://dendrix.oeiuwq.com/index.html).

## 🙇 Acknowledgements

- [Elevate Your Nix Config With Dendritic Pattern @ Vimjoyer's YouTube](https://www.youtube.com/watch?v=-TRbzkw6Hjs).
- [Refactoring My Infrastructure As Code Configurations @ Not a Number](https://not-a-number.io/2025/refactoring-my-infrastructure-as-code-configurations/)
  ([PIAnC - Personal Infrastructure As (Nix) Code @ GitHub](https://github.com/drupol/infra)).
- [Exploring the Dendritic Nix Pattern @ Benedikt Ritter](https://britter.dev/blog/2026/05/11/exploring-the-dendritic-nix-pattern/).
