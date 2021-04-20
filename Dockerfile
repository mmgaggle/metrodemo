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

RUN curl -O https://downloads.mariadb.com/Connectors/odbc/connector-odbc-3.1.7/mariadb-connector-odbc-3.1.7-ga-rhel7-x86_64.tar.gz
RUN tar xvzf mariadb-connector-odbc-3.1.7-ga-rhel7-x86_64.tar.gz
RUN install lib64/libmaodbc.so /usr/lib64/
RUN install -d /usr/lib64/mariadb/
RUN install -d /usr/lib64/mariadb/plugin/
RUN install lib64/mariadb/plugin/auth_gssapi_client.so /usr/lib64/mariadb/plugin/
RUN install lib64/mariadb/plugin/caching_sha2_password.so /usr/lib64/mariadb/plugin/
RUN install lib64/mariadb/plugin/client_ed25519.so /usr/lib64/mariadb/plugin/
RUN install lib64/mariadb/plugin/dialog.so /usr/lib64/mariadb/plugin/
RUN install lib64/mariadb/plugin/mysql_clear_password.so /usr/lib64/mariadb/plugin/
RUN install lib64/mariadb/plugin/sha256_password.so /usr/lib64/mariadb/plugin/
RUN yum install -y git maven unixODBC-devel openssl-devel openssl
RUN pip install wheel
RUN pip install shortuuid pyodbc
RUN mkdir -p /opt/builds
COPY build.py /usr/bin/build.py
RUN chmod 777 /opt/builds
RUN chmod 755 /usr/bin/build.py

USER 1001
CMD python3 /usr/bin/build.py
