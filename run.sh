#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

declare host
declare password
declare port
declare username

host=$(bashio::services "mqtt" "host")
password=$(bashio::services "mqtt" "password")
port=$(bashio::services "mqtt" "port")
username=$(bashio::services "mqtt" "username")

exec usr/bin/qbus/./qbusMqttGw -serial="QBUSMQTTGW" -logbuflevel -1 -logtostderr true -storagedir /opt/qbus -mqttbroker "tcp://$host:$port" -mqttuser "$username" -mqttpassword "$password"