ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git \
    && git clone https://github.com/QbusKoen/qbusMqtt \
    && GW2USE=="qbusMqttGw-arm.tar" \
    && if [ "${BUILD_ARCH}" = "i386" ]; then GW2USE="qbusMqttGw-x86.tar"; \
    elif [ "${BUILD_ARCH}" = "amd64" ]; then GW2USE="qbusMqttGw-x64.tar"; fi \
    \
    && cd /qbusMqtt/qbusMqtt/qbusMqttGw \
    && tar -xf "${GW2USE}" \
    && cd / \
    && mkdir /usr/bin/qbus \
    && mkdir /opt/qbus \
    && cp -R qbusMqtt/qbusMqtt/fw/ /opt/qbus/ \
    && cp qbusMqtt/qbusMqtt/puttftp /opt/qbus/ \
    && cp qbusMqtt/qbusMqtt/qbusMqttGw/qbusMqttGw /usr/bin/qbus/ \
    && chmod +x /usr/bin/qbus/qbusMqttGw \
    && chmod +x /opt/qbus/puttftp

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]