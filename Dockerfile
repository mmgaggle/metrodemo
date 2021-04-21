FROM ubi8
ENV ENABLE_MICROPIPENV="1" \
    UPGRADE_PIP_TO_LATEST="1" \
USER root

COPY .s2i/bin /tmp/scripts
# Copying in source code
COPY . /tmp/src

RUN yum install -y git maven

RUN mkdir -p /opt/builds
RUN chmod 777 /opt/builds
RUN chmod 755 /tmp/src/build.py

USER 1001

RUN /tmp/scripts/assemble
CMD /tmp/scripts/run
