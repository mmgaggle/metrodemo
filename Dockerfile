FROM quay.io/centos/centos:stream
ENV JUPYTER_ENABLE_LAB="true" \
    ENABLE_MICROPIPENV="1" \
    UPGRADE_PIP_TO_LATEST="1" \
    WEB_CONCURRENCY="1" \
    THOTH_ADVISE="0" \
    THOTH_ERROR_FALLBACK="1" \
    THOTH_DRY_RUN="1" \
    THAMOS_DEBUG="0" \
    THAMOS_VERBOSE="1" \
    THOTH_PROVENANCE_CHECK="0"
USER root

RUN yum install -y epel-release python3-pip git maven
RUN pip install shortuuid MySQL-python
RUN mkdir -p /opt/builds
COPY build.py /usr/bin/build.py
RUN chmod 777 /opt/builds
RUN chmod 755 /usr/bin/build.py

USER 1001
CMD python3 /usr/bin/build.py
