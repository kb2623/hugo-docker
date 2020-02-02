FROM archlinux:20200106

USER root
WORKDIR /root

RUN pacman --noconfirm -Syyu \
 && pacman-db-upgrade \
 && pacman -S --noconfirm bash git vim neovim curl tmux vifm hugo

RUN mkdir -p /mnt/data

USER root
WORKDIR /mnt/data
VOLUME /mnt/data
EXPOSE 1313
ENTRYPOINT ["/bin/bash"]
