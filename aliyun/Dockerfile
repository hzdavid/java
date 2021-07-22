FROM registry.cn-hangzhou.aliyuncs.com/shxm/java:11

LABEL MAINTAINER buzzxu <downloadxu@163.com>

VOLUME /tmp

RUN set -eux; \
apt-get clean && \
    apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends wget zip unzip && \
    wget "http://arms-apm-hangzhou.oss-cn-hangzhou.aliyuncs.com/2.7.1.1-jdk11/ArmsAgent.zip" -O ArmsAgent.zip && \
    unzip ArmsAgent.zip -d /root/ && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENV JAVA_OPTS_ARAMS '-javaagent:/root/ArmsAgent/arms-bootstrap-1.7.0-SNAPSHOT.jar -Darms.licenseKey='${arms_licenseKey}' -Darms.appName='${arms_appName}

ENTRYPOINT ["java","-version"]