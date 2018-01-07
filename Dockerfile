FROM openjdk:8-jre

ARG OPENDJ_VERSION
ENV OPENDJ_VERSION ${OPENDJ_VERSION:-3.0.0}

ARG BASE_DN
ENV BASE_DN ${BASE_DN:-"dc=st,dc=sk"}

ARG ROOT_DN
ENV ROOT_DN ${ROOT_DN:-"cn=Directory Manager"}

ARG ROOT_PWD
ENV ROOT_PWD ${ROOT_PWD:-"password"}

ARG ROOT_PORT
ENV ROOT_PORT ${ROOT_PORT:-4444}

ARG BASE_PORT
ENV BASE_PORT ${BASE_POrT:-1389}

RUN apt-get update && \
    apt-get install -y zip net-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    addgroup --gid 1001 opendj && \
    adduser --system --home "/home/opendj" --shell /bin/bash --uid 1001 --ingroup opendj  --disabled-password opendj && \
    mkdir -p /opt/opendj /home/opendj/conf && \
    chown opendj:opendj -R /opt/opendj /home/opendj

ADD bin/* /bin/
RUN chmod +x /bin/*.sh

ADD sources/OpenDJ-${OPENDJ_VERSION}.zip /tmp/opendj.zip
RUN chown opendj:opendj -R /tmp/opendj.zip

RUN /bin/opendj_config.sh

USER opendj

RUN cd /tmp && \
    unzip /tmp/opendj.zip -d /opt && \
    rm -rf /tmp/opendj.zip

RUN cd /opt/opendj && \
    ./setup --cli --propertiesFilePath "/home/opendj/conf/opendj-install.properties" --acceptLicense --no-prompt

RUN cd /opt/opendj && \
    ./bin/status

EXPOSE $BASE_PORT