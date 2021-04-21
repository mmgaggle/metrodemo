FROM registry.access.redhat.com/ubi8/s2i-base
ENV ENABLE_MICROPIPENV="1" \
    UPGRADE_PIP_TO_LATEST="1"
USER root

COPY .s2i/bin /tmp/scripts
# Copying in source code
COPY . /tmp/src

RUN chown -R 1001:0 /tmp/scripts /tmp/src

RUN yum install -y git maven

RUN mkdir -p /opt/builds
RUN chmod 777 /opt/builds
RUN chmod 755 /tmp/build.py

USER 1001

RUN /tmp/scripts/assemble
CMD /tmp/scripts/run
