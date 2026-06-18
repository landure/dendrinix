/**
  # Grim & Satty for Niri

  Grim command-line screenshot tool, with Satty image annotation tool.
  
  Add this to Niri's `config.kdl`:

  ```kdl
  binds {
    // Capture.
    Mod+S            hotkey-overlay-title="Screenshot (region)" { spawn "dfr-screenshot" "region"; }
    Mod+Shift+S      hotkey-overlay-title="Screenshot (window)" { spawn "dfr-screenshot" "window"; }
    Mod+Ctrl+S       hotkey-overlay-title="Screenshot (monitor: focused)" { spawn "dfr-screenshot" "monitor-focused"; }
    Mod+Ctrl+Shift+S hotkey-overlay-title="Screenshot (monitor: all)" { spawn "dfr-screenshot" "monitor-all"; }
  };

  // Avoid writing screenshots to disk since they get piped into satty.
  screenshot-path null
  ```

  ## 🛠️ Tech Stack

  - [Satty @ GitHub](https://github.com/Satty-org/Satty).
  - [grim @ Freedesktop's GitLab](https://gitlab.freedesktop.org/emersion/grim).
  - [slurp @ GitHub](https://github.com/emersion/slurp).
  - [wl-clipboard @ GitHub](https://github.com/bugaevc/wl-clipboard).
  - [jq homepage](https://jqlang.org/)
    ([jq @ GitHub](https://github.com/jqlang/jq)).
  - [Niri homepage](https://niri-wm.github.io/niri/)
    ([Niri @ GitHub](https://github.com/niri-wm/niri)).

  ## 📝 Documentation

  ### 🏠 Home Manager

  - [programs.jq](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.jq.enable).
  - [programs.satty](https://nix-community.github.io/home-manager/options.xhtml#opt-programs.satty.enable).

  ## 🙇 Acknowledgements

  - [Wayland Compatible Annotated Screenshots with slurp, grim and satty @ Nick Janetakis](https://nickjanetakis.com/blog/wayland-compatible-annotated-screenshots-with-slurp-grim-and-satty)
    ([dfr-screenshot @ 🥡 DotFriedRice's GitHub](https://github.com/nickjj/dotfriedrice/blob/master/.local/bin/dfr-screenshot)).
*/
{
  biapy.skim = {
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        inherit (lib.meta) getExe;
        inherit (lib.modules) mkDefault;

        grim_exe = getExe pkgs.grim;
        slurp_exe = getExe pkgs.slurp;
        jq_exe = getExe programs.jq.package;
        satty_exe = getExe programs.satty.package;
        wl-copy_exe = getExe' pkgs.wl-clipboard "wl-copy";
        wl-paste_exe = getExe' pkgs.wl-clipboard "wl-paste";
      in
      {
        home.packages = with pkgs; [
          grim
          slurp
          wl-clipboard

          (pkgs.writeShellScriptBin "dfr-screenshot" ''
            # Open with Neovim.
            # Should use xargs.
            # see https://ivergara.github.io/Supercharging-shell.html
                        
            set -o errexit
            set -o pipefail
            set -o nounset

            MODE="${"1:-region"}"

            case "${MODE}" in
              region)
                ${grim_exe} -g "$(${slurp_exe} -d)" -
                ;;
              window)
                niri msg action screenshot-window
                sleep 0.5
                ${wl-paste_exe} --type 'image/png'
                ;;
              monitor-focused)
                ${grim_exe} -o "$(niri msg --json focused-output |
                  ${jq_exe} --raw-output .name)" -
                ;;
              monitor-all)
                ${grim_exe} -
                ;;
              *)
                echo "'${MODE}' is not a supported, aborting!" >&2
                exit 1
                ;;
            esac |
            ${satty_exe} --filename - --output-filename "${XDG_PICTURES_DIR}/screenshot-%+.png"
          '')
        ];

        programs.satty = {
          enable = mkDefault true;
          settings = {
            general = {
              # Exit directly after copy / save action.

              early-exit = mkDefault true;
              # fullscreen = true;
              corner-roundness = mkDefault 12;

              # Select the tool on startup:
              #   pointer, crop, line, arrow, rectangle, text, marker, blur, brush
              initial-tool = mkDefault "brush";

              # Ensure clipboard contents persist after satty closes.
              copy-command = mkDefault "${wl-copy_exe} --type image/png";

              # output-filename = "/tmp/test-%Y-%m-%d_%H:%M:%S.png";
            };

            # color-palette = {
            #   palette = [ "#00ffff" "#a52a2a" "#dc143c" "#ff1493" "#ffd700" "#008000" ];
            # };
          };
        };
      };
  };
}
