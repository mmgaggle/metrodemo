FROM quay.io/thoth-station/s2i-thoth-ubi8-py38:v0.26.0
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

RUN yum install -y git maven
RUN pip install shortuuid psycopg2
RUN mkdir -p /opt/builds
COPY build.py /usr/bin/build.py
RUN chmod 777 /opt/builds
RUN chmod 755 /usr/bin/build.py

USER 1001
CMD python3 /usr/bin/build.py
