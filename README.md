# arch-distrobox

[![build-arch-distrobox](https://github.com/ublue-os/arch-distrobox/actions/workflows/build.yml/badge.svg)](https://github.com/ublue-os/arch-distrobox/actions/workflows/build.yml) 

Arch image designed for use in distrobox. This image includes all of the packages normally installed by distrobox on first start, [paru](https://github.com/Morganamilo/paru) pre-installed, and a modified [xdg-utils](https://github.com/KyleGospo/xdg-utils-distrobox-arch) that allows the container to open your host operating system's web browsers and file explorer.

A few other niceties are also added, namely:

* starship prompt
* zsh plus highlighting and autosuggestions
* atuin (magical shell history)
* bat
* btop
* bottom
* dust
* dysk
* eza (exa clone)
* fd
* fzf
* just (command runner)
* ouch (unzipping utility)
* ripgrep
* p7zip
* yt-dlp
* ytfzf
* zoxide

Furthermore some things more focussed on my dev work:

* aws-cli V2
* docker and docker-slim
* git-remote-codecommit (for interacting with AWS Codecommit)
* git-delta (visually nice diff viewer)
* libsecret (for storing things like git credentials)
* rtx (runtime chooser)
* gitui (TUI git interface)
* helix (terminal editor)
* neovim (mostly for legacy purposes now)

Lastly, in order to be able to use this image more seamlessly as a full-time
shell environment a few things are linked to `distrobox-host-exec` which
means that they'll be executed on the host transparently. This includes:

* flatpak
* docker
* podman
* rpm-ostree
* distrobox (be careful with this as it can easily kill the current shell session)

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/ublue-os/arch-distrobox
