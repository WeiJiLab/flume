FROM nginx:alpine

ARG APK_MIRROR_SOURCE_URL
ARG APK_ORI_SOURCE_URL='dl-cdn.alpinelinux.org'
ARG DOWNLOAD_SOURCE='http://www.apache.org/dyn/closer.lua/flume'

ARG FLUME_VERSION

ENV SHELL /bin/bash
ENV FLUME_HOME /opt/flume
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:${JAVA_HOME}/bin:${FLUME_HOME}/bin:${FLUME_HOME}/sbin

######################################################################
# install infrastructure
RUN if [ "${APK_MIRROR_SOURCE_URL}" != "" ]; then \
        sed -i "s/${APK_ORI_SOURCE_URL}/${APK_MIRROR_SOURCE_URL}/g" /etc/apk/repositories; \
    fi

RUN apk add bash openjdk8=8.252.09-r0 \
    && rm -rf /var/cache/apk/*

RUN if [ "${APK_MIRROR_SOURCE_URL}" != "" ]; then \
        sed -i "s/${APK_MIRROR_SOURCE_URL}/${APK_ORI_SOURCE_URL}/g" /etc/apk/repositories; \
    fi

######################################################################
# install flume
RUN curl -v -L "${DOWNLOAD_SOURCE}/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz" --output apache-flume.tar.gz \
    && mkdir -p "${FLUME_HOME}" \
    && tar -zxvf /apache-flume.tar.gz -C "${FLUME_HOME}" --strip-components 1 \
    && rm -f /apache-flume.tar.gz \
    && mkdir -p /opt/flume/sbin \
    && echo "flume-ng agent -n \${FLUME_AGENT_NAME} --conf /opt/flume/conf -f /opt/flume/conf/flume-conf.properties" > /opt/flume/sbin/start.sh \
    && chmod 755 /opt/flume/sbin/start.sh \
    && mkdir -p /opt/flume/exlib

ENTRYPOINT nginx && start.sh