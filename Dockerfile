FROM debian:buster-slim AS jlink   

ARG JAVA_VERSION=16.0.1
ARG JAVA_TAR_FILE=jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz
ENV JAVA_HOME=/usr/local/jdk-${JAVA_VERSION}

RUN set -eux; \
    cd /tmp && \
    # apk add wget tar gzip binutils && \
    apt-get update; \
    apt-get install -y --no-install-recommends wget binutils && \
    wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}+9/7147401fd7354114ac51ef3e1328291f/${JAVA_TAR_FILE}" && \
    tar zxvf ${JAVA_TAR_FILE} -C /usr/local && \
    echo "JAVA_HOME=$JAVA_HOME" >> /etc/profile && \
    echo "PATH=$PATH:$JAVA_HOME/bin" >> /etc/profile && \
    echo "export PATH JAVA_HOME" >> /etc/profile && \
    /bin/bash -c "source /etc/profile" && \
    jdir=$(dirname $(dirname $(find / -name javac))) && \
    $JAVA_HOME/bin/jlink --compress=2  --no-man-pages --no-header-files --strip-debug --module-path ${jdir}/jmods  --add-modules java.base,java.desktop,java.instrument,java.logging,java.management,java.net.http,java.naming,java.rmi,java.security.jgss,java.sql,java.sql.rowset,java.xml,jdk.unsupported,java.scripting,jdk.dynalink,jdk.incubator.foreign,jdk.jdwp.agent,jdk.jsobject,jdk.net,jdk.nio.mapmode,jdk.sctp --bind-services --output /jre  

FROM debian:buster-slim

LABEL MAINTAINER=buzzxu<downloadxu@163.com>

ADD sources.list /etc/apt/

RUN rm -rf /var/lib/apt/lists/* && \  
    apt-get clean && \
    apt-get update -qq && \ 
    apt-get upgrade -y && \
    apt-get install -qq -y --no-install-recommends openssl libfontconfig1 ca-certificates p11-kit && \
    update-ca-certificates && \
    rm /etc/localtime && \
    ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \ 
    echo "Asia/Shanghai" > /etc/timezone && \
    mkdir -p /opt/jre && \
    chmod a+x /opt/jre && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* 

COPY --from=jlink /jre /opt/jre/ 
    

ENV TZ=Asia/Shanghai
ENV LANG='C.UTF-8' LC_ALL='C.UTF-8'
ENV JAVA_VERSION 16
ENV JAVA_HOME=/opt/jre \
    PATH="/opt/jre/bin:$PATH"