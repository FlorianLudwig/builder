FROM fedora:25

COPY requirements.txt /root/

RUN \
    # enable rpm fusion \
    dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    dnf install -y python-pip gcc gcc-c++ make nodejs bzip2 nodejs npm git libffi-devel redhat-rpm-config python-devel ffmpeg-devel libxml2-devel libxslt-devel && \
    cd /root && \
    pip install -r /root/requirements.txt && \
    npm install -g react-tools browserify babelify babel-preset-react watchify js-yaml eslint babel-eslint karma-firefox-launcher karma-chai karma-browserify karma-spec-reporter requirejs && \
    dnf clean all && \
    rm -rf /tmp/*

WORKDIR /app
