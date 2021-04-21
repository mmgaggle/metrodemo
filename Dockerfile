FROM registry.access.redhat.com/ubi8/python-38
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
COPY build.py /usr/bin/build.py
RUN chmod 755 /usr/bin/build.py

USER 1001

RUN /tmp/scripts/assemble
CMD /tmp/scripts/run
