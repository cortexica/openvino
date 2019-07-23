FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
LABEL maintainer="info@cortexica.com"

COPY nv-tensorrt-repo-ubuntu1804-cuda10.0-trt5.1.2.2-rc-20190227_1-1_amd64.deb /tmp/
RUN dpkg -i /tmp/nv-tensorrt-repo-ubuntu1804-cuda10.0-trt5.1.2.2-rc-20190227_1-1_amd64.deb \
    && apt-get -y update && apt-get install -y --no-install-recommends \
        lsb-release \
        cpio \
        sudo \
        wget \
        libnvinfer5=5.1.2-1+cuda10.0 \
        libnvinfer-dev=5.1.2-1+cuda10.0 \
    && rm -rf /var/lib/apt/lists/*

# Install OpenVino
RUN wget -O /tmp/openvino.tar.gz http://registrationcenter-download.intel.com/akdlm/irc_nas/15382/l_openvino_toolkit_p_2019.1.094_online.tgz \
    && tar -xzf /tmp/openvino.tar.gz -C /tmp \
    && rm /tmp/openvino.tar.gz \
    && cd /tmp/l_openvino_*_online \
    && sed -i 's/^\(ACCEPT_EULA\)=.*$/\1=accept/' silent.cfg \
    && echo "Installing OpenVino..." \
    && ./install.sh -s silent.cfg \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

# Set default runtime to python3
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10
ENV PYTHONPATH=${PYTHONPATH}:/opt/intel/openvino/python/python3.6

# Append library path
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/intel/openvino/deployment_tools/inference_engine/lib/intel64:/usr/local/cuda-10.0/compat/:/usr/x86_64-linux-gnu

ADD demo.sh .
