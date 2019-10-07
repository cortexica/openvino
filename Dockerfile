FROM ubuntu:18.04
LABEL maintainer="info@cortexica.com"

RUN apt-get -y update && apt-get install -y --no-install-recommends \
        lsb-release \
        cpio \
        sudo \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install OpenVino   
RUN wget -O /tmp/openvino.tar.gz http://registrationcenter-download.intel.com/akdlm/irc_nas/15944/l_openvino_toolkit_p_2019.3.334_online.tgz \
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
ENV PYTHONPATH=${PYTHONPATH}:/opt/intel/openvino/python/python3.6:/opt/intel/openvino/python/python3

# Append library path
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/opt/intel/openvino/opencv/lib:/opt/intel/opencl:\
/opt/intel/openvino/deployment_tools/inference_engine/external/hddl/lib:\
/opt/intel/openvino/deployment_tools/inference_engine/external/gna/lib:\
/opt/intel/openvino/deployment_tools/inference_engine/external/mkltiny_lnx/lib:\
/opt/intel/openvino/deployment_tools/inference_engine/external/tbb/lib:\
/opt/intel/openvino/deployment_tools/inference_engine/lib/intel64:/opt/intel/openvino/openvx/lib

ADD demo.sh .
