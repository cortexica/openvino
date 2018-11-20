FROM ubuntu:16.04
LABEL maintainer="info@cortexica.com"

RUN apt-get -y update && apt-get install -y --no-install-recommends \
        lsb-release \
        cpio \
        sudo \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install OpenVino
RUN wget -O /tmp/openvino.tar.gz http://registrationcenter-download.intel.com/akdlm/irc_nas/14920/l_openvino_toolkit_p_2018.4.420_online.tgz \
    && tar -xzf /tmp/openvino.tar.gz -C /tmp \
    && rm /tmp/openvino.tar.gz \
    && cd /tmp/l_openvino_*_online \
    && sed -i 's/^\(ACCEPT_EULA\)=.*$/\1=accept/' silent.cfg \
    && echo "Installing OpenVino..." \
    && ./install.sh -s silent.cfg \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/l_openvino*

# Set default runtime to python3
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
ENV PYTHONPATH=${PYTHONPATH}:/opt/intel/computer_vision_sdk/python/python3.5/ubuntu16

# Append library path
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/intel/computer_vision_sdk/deployment_tools/inference_engine/lib/ubuntu_16.04/intel64

ADD demo.sh .
