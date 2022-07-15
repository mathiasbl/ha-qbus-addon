ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH

ARG GW2USE="qbusMqttGw-x64.tar"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git

RUN	git clone https://github.com/QbusKoen/qbusMqtt

WORKDIR /qbusMqtt/qbusMqtt/qbusMqttGw
RUN	tar -xf "$GW2USE"
WORKDIR /

RUN mkdir /usr/bin/qbus
RUN	mkdir /opt/qbus

RUN	cp -R qbusMqtt/qbusMqtt/fw/ /opt/qbus/
RUN	cp qbusMqtt/qbusMqtt/puttftp /opt/qbus/
RUN	cp qbusMqtt/qbusMqtt/qbusMqttGw/qbusMqttGw /usr/bin/qbus/

RUN	chmod +x /usr/bin/qbus/qbusMqttGw
RUN	chmod +x /opt/qbus/puttftp

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]