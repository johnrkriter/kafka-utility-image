# kafka-utility-image
Container that can be used to debug kafka clusters

## Acknowledgements
This project is built upon a number of other great items. In no way are we trying to take way from any of these components. This repo and image is simply a conveniance tool used by teams to troubleshoot different issues with kafka infrastrcuture without running multiple containers.

All projcts are the property of their respective owners.
## To build
External access to the internet is required to build this image. This is due to other dependencies installed during the build process, as well as an apt updat.e

To build locally
1. clone the master branch of this repo
2. navigate to the directory root and run `docker build -t kafka-utility-image:local .`

## To run locally
This image is intended to be used interactively to run tests against kafka clusters(including Confluent Cloud)

To run locally with docker
1. pull the latest image from dockerhub `docker pull jkriter/kafka-utility-image:latest`
2. Run the image interactively with docker `docker run -it --entrypoint bash jkriter/kafka-utility-image:latest`


## To run in Kubernetes
Included in the kubernetes folder is a example deployment that allows the kafka-utility-image to be deployed as a static pod. This can then be accessed by team members.

