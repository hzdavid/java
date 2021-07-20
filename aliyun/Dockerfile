FROM registry.cn-hangzhou.aliyuncs.com/shxm/java:latest

LABEL buzzxu <downloadxu@163.com>

VOLUME /tmp

ENV arms_licenseKey={LicenseKey}
ENV arms_appName={AppName}

RUN set -eux; \
apt-get clean && \
    apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends wget zip unzip && \
    wget "http://arms-apm-hangzhou.oss-cn-hangzhou.aliyuncs.com/ArmsAgent.zip" -O ArmsAgent.zip && \
    unzip ArmsAgent.zip -d /root/ && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENTRYPOINT ["java","-version"]