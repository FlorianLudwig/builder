FROM fedora:25

COPY requirements.txt /root/

RUN dnf install -y python-pip gcc gcc-c++ make nodejs bzip2 nodejs npm git && \
    cd /root && \
    pip install -r /root/requirements.txt && \
    npm install -g react-tools browserify babelify babel-preset-react watchify js-yaml eslint babel-eslint karma-firefox-launcher karma-chai karma-browserify karma-spec-reporter requirejs && \
    dnf clean all && \
    rm -rf /tmp/*

WORKDIR /app
