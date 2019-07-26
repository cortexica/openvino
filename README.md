[![Build Status](https://travis-ci.org/cortexica/openvino.svg?branch=master)](https://travis-ci.org/cortexica/openvino)
[![Docker Build Status](https://img.shields.io/docker/cloud/build/cortexica/openvino)](https://cloud.docker.com/u/cortexica/repository/docker/cortexica/openvino/builds)

## OpenVINO Docker Image

[OpenVINO](https://software.intel.com/en-us/openvino-toolkit) is a toolkit for optimising Machine Learning models to run efficiently on a range of Intel devices.

### Links

* [Dockerhub repository](https://hub.docker.com/r/cortexica/openvino)
* [Build status](https://hub.docker.com/r/cortexica/openvino/builds)

### Pull from Dockerhub
```bash
docker pull cortexica/openvino:latest
```
Available tags:

| Tag           | Size   |
|---------------|--------|
| `2019_R2`     | 868 MB |
| `2019_R1`     | 483 MB |
| `2018_R5`     | 893 MB |
| `2018_R4`     | 2.0 GB |
| `2018_R3`     | 1.0 GB |
| `2018_R2.0.2` | 1.0 GB |
| `2018_R2`     | 997 MB |

Run the demo:
```bash
docker run -it --rm cortexica/openvino:latest ./demo.sh
```


### Building the docker image locally

To build locally:
```bash
docker build -t openvino . 
```

Run the demo:
```bash
docker run -it --rm openvino ./demo.sh
```
