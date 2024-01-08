FROM quay.io/toolbx-images/archlinux-toolbox AS arch-distrobox

# Pacman Initialization
# Create build user
RUN sed -i 's/#Color/Color/g' /etc/pacman.conf && \
    sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j$(nproc)"/g' /etc/makepkg.conf && \
    pacman-key --init && pacman-key --populate && \
    pacman -Syu --noconfirm && \
    pacman -S \
        wget \
        base-devel \
        git \
        --noconfirm && \
    useradd -m --shell=/bin/bash build && usermod -L build && \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Distrobox Integration
USER build
WORKDIR /home/build
RUN git clone https://github.com/KyleGospo/xdg-utils-distrobox-arch.git --single-branch && \
    cd xdg-utils-distrobox-arch/trunk && \
    makepkg -si --noconfirm && \
    cd ../.. && \
    rm -drf xdg-utils-distrobox-arch
USER root
WORKDIR /
RUN git clone https://github.com/89luca89/distrobox.git --single-branch /tmp/distrobox && \
    cp /tmp/distrobox/distrobox-host-exec /usr/bin/distrobox-host-exec && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/flatpak && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/docker && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/podman && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/rpm-ostree && \
    ln -s /usr/bin/distrobox-host-exec /usr/bin/distrobox && \
    wget https://github.com/1player/host-spawn/releases/download/$(cat /tmp/distrobox/distrobox-host-exec | grep host_spawn_version= | cut -d "\"" -f 2)/host-spawn-$(uname -m) -O /usr/bin/host-spawn && \
    chmod +x /usr/bin/host-spawn && \
    rm -drf /tmp/distrobox

# Install packages Distrobox adds automatically, this speeds up first launch
RUN pacman -S \
        bash-completion \
        bc \
        curl \
        diffutils \
        findutils \
        glibc \
        gnupg \
        inetutils \
        keyutils \
        less \
        lsof \
        man-db \
        man-pages \
        mlocate \
        mtr \
        ncurses \
        nss-mdns \
        openssh \
        pigz \
        pinentry \
        procps-ng \
        rsync \
        shadow \
        sudo \
        tcpdump \
        time \
        traceroute \
        tree \
        tzdata \
        unzip \
        util-linux \
        util-linux-libs \
        vte-common \
        wget \
        words \
        zip \
        --noconfirm \
        --needed

# Add paru and install AUR packages
USER build
WORKDIR /home/build
RUN git clone https://aur.archlinux.org/paru-bin.git --single-branch && \
    cd paru-bin && \
    makepkg -si --noconfirm && \
    cd .. && \
    rm -drf paru-bin && \
    paru -S \
        atuin \
        aws-cli-v2 \
        bat \
        bottom \
        devbox-bin \
        direnv \
        dive \
        docker-compose \
        docker-slim \
        dust \
        dysk \
        exa \
        fd \
        fzf \
        git-delta \
        git-remote-codecommit \
        gitui \
        hadolint-bin \
        helix \
        jless \
        just \
        lazygit \
        libsecret \
        neovim \
        ouch \
        ripgrep \
        rtx-bin \
        shellcheck-bin \
        starship \
        watchexec \
        wl-clipboard \
        yazi \
        yt-dlp \
        ytfzf \
        zellij \
        zoxide \
        zsh \
        zsh-autosuggestions \
        zsh-syntax-highlighting \
        --noconfirm \
        --needed

USER root
WORKDIR /

# Helix symlink
RUN ln -s /usr/lib/helix/hx /usr/bin/hx 

# Cleanup
RUN sed -i 's@#en_US.UTF-8@en_US.UTF-8@g' /etc/locale.gen && \
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf && \
    locale-gen && \
    userdel -r build && \
    rm -drf /home/build && \
    sed -i '/build ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    sed -i '/root ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    rm -rf \
        /tmp/* \
        /var/cache/pacman/pkg/*

