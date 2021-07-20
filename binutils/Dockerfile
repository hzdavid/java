FROM registry.cn-hangzhou.aliyuncs.com/shxm/java:aliyun

LABEL buzzxu <downloadxu@163.com>

VOLUME /tmp

RUN set -eux; \
apt-get clean && \
    apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ffmpeg && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ENTRYPOINT ["java","-version"]