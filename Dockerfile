FROM archlinux:base-devel

LABEL org.opencontainers.image.authors="Sushrut1101 <guptasushrut@gmail.com>"

# Setup pacman
RUN \
    printf "\nParallelDownloads = 20\n" >> /etc/pacman.conf && \
    pacman -Sy --noconfirm archlinux-keyring && \
    pacman-key --init && \
    pacman-key --populate && \
    pacman -Syyu --noconfirm

# Install basic packages
RUN pacman -S --noconfirm \
    sudo git curl wget openssh

# Install uv
RUN UV_INSTALL_DIR="/usr/local/bin" \
    bash -c "$(curl -LsSf https://astral.sh/uv/install.sh)" && \
    rm -rf /usr/local/bin/env{,.fish}

# Setup DumprX
RUN bash -c "$(curl -sL https://github.com/DumprX/DumprX/raw/refs/heads/main/setup.sh)"

# Default command
CMD ["/bin/bash"]
