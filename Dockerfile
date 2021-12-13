
FROM busybox:latest as confluent-binaries
WORKDIR /tmp
RUN wget -O confluent-community.zip https://packages.confluent.io/archive/6.2/confluent-community-6.2.2.zip && unzip confluent-community.zip 

FROM purbon/kafka-topology-builder:2.1.3 as julieops

FROM confluentinc/cp-kafkacat:6.2.2 as kafkacat

FROM confluentinc/cp-kafka:6.2.2 AS final
USER root
WORKDIR /usr/local
ENV CONFLUENT_HOME=/home/appuser/confluent-6.2.2
COPY --from=kafkacat /usr/local/bin/kafkacat /usr/local/bin/kafkacat
COPY --from=confluent-binaries --chown=appuser:appuser /tmp/confluent-6.2.2/ /home/appuser/confluent-6.2.2/
COPY --from=julieops --chown=appuser:appuser --chmod=0777 /usr/local/julie-ops/bin/julie-ops.jar /usr/local/julie-ops/bin/julie-ops.jar
COPY --from=julieops --chown=appuser:appuser --chmod=0777 /usr/local/julie-ops/julie-ops-cli.sh /home/appuser/julie-ops-cli.sh
RUN curl -L --http1.1 https://cnfl.io/ccloud-cli | sh -s
RUN yum updateinfo && yum install -y \
	git \
	vim \
	nano \
	dos2unix
RUN yum clean all
USER appuser
ENTRYPOINT sleep infinity