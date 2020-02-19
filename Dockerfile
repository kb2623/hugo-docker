FROM archlinux:20200106

ARG USER_ID=1000
ARG USER_NAME=klemen
ARG USER_PASSWORD=klemen
ARG GROUP_ID=1000
ARG GROUP_NAME=klemen
ARG USER_HOME=/home/${USER_NAME}
ARG USER_EMAIL=$USER_NAME@docker.me

USER root
WORKDIR /root

# Update, upgrade and install needed programs
RUN pacman --noconfirm -Syyu \
 && pacman-db-upgrade \
 && pacman -S --noconfirm make bash curl bash wget tmux git vim neovim vifm hugo openssl

# Create group and user
RUN rm -f /etc/skel/.bashrc
ADD .bashrc /etc/skel
RUN groupadd -g ${GROUP_ID} ${GROUP_NAME} \
 && useradd -m -d ${USER_HOME} -u ${USER_ID} -g ${GROUP_NAME} -s /bin/bash -p $(openssl passwd -6 -salt archlinux20200106 "${USER_PASSWORD}") -c 'Hugo user' ${USER_NAME}
 
# Create shared dir
RUN mkdir -p /mnt/data \
 && chown -R ${USER_ID}:${GROUP_ID} /mnt/data

USER ${USER_NAME}
WORKDIR /mnt/data

RUN git config --global user.email $USER_EMAIL \
 && git config --global user.name $USER_NAME

VOLUME /mnt/data
EXPOSE 1313

ENTRYPOINT ["/bin/bash"]
