FROM ln-editor.c.r0k.de/base

RUN \
    # enable rpm fusion \
    dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    curl https://dl.yarnpkg.com/rpm/yarn.repo > /etc/yum.repos.d/yarn.repo && \
    dnf -y install dnf-plugins-core && \
    dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo && \
    dnf install -y python-pip gcc gcc-c++ make nodejs npm bzip2 git \
                   libffi-devel redhat-rpm-config python-devel ffmpeg-devel \
                   libxml2-devel libxslt-devel xorg-x11-server-Xvfb \
                   xorg-x11-xauth which docker-ce openssl-devel.x86_64 \
                   libjpeg-turbo-devel \
                   yarn \
                   cairo-devel && \
    dnf clean all && \
    rm -rf /tmp/*

COPY requirements.txt requirements-dev.txt package.json /root/

RUN \
    cd /root && \
    pip install -r /root/requirements.txt -r /root/requirements-dev.txt && \
    yarn install --modules-folder /app/node_modules && \
    rm -rf /tmp/*

WORKDIR /app
