FROM wxdlong/jdk:8u201 as jdk
FROM wxdlong/wildfly:17.0.0 as wildfly

FROM centos:7

##service:jmx:http-remoting-jmx://localhost:32771
#install packages
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y vim iproute ping tar wget

COPY --from=jdk /* /tmp/
COPY --from=wildfly /* /tmp/


ENV JAVA_HOME /opt/jdk1.8.0_201
ENV WILDFLY_HOME /opt/wildfly-17.0.0.Final/


## Default userName=wxdlong, password=12345678

RUN tar -xvf /tmp/jdk-8u201-linux-x64.tar.gz -C /opt && \
    tar -xvf /tmp/wildfly-17.0.0.Final.tar.gz -C /opt && \
    echo "export JAVA_HOME=${JAVA_HOME}" >> /etc/profile && \
    echo "export WILDFLY_HOME=${WILDFLY_HOME}" >> /etc/profile && \
    echo 'export PATH=${WILDFLY_HOME}/bin:${JAVA_HOME}/bin:${PATH}' >> /etc/profile && \
    echo 'wxdlong=4407fd27b8054006858784d84fb967d0' >> ${WILDFLY_HOME}/standalone/configuration/mgmt-users.properties && \
    echo 'wxdlong=' >> ${WILDFLY_HOME}/standalone/configuration/mgmt-groups.properties && \
    rm -rf /tmp/*.tar.gz

COPY init.sh /usr/local/sbin
    
EXPOSE 9990 9999 8080
WORKDIR /opt/${WILDFLY_HOME}
CMD ["init.sh"]
