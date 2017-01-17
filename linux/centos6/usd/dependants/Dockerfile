############################################################
# Dockerfile that builds and runs dependant docker files

FROM usd-docker/usd:centos6-usd-0.7.2

MAINTAINER Animal Logic
COPY scripts/build_alusdmaya.sh /tmp/
RUN /tmp/build_alusdmaya.sh
CMD bash
