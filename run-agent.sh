#!/bin/bash

# Konfiguriere den TeamCity-Agenten
if [ ! -f ./conf/buildAgent.properties ]; then
  # cp ./conf.dist/buildAgent.dist.properties ./conf/buildAgent.properties
  cp ./conf/buildAgent.dist.properties ./conf/buildAgent.properties
  sed -i -e "s|^serverUrl=.*|serverUrl=${SERVER_URL}|" ./conf/buildAgent.properties
fi

# Starte den TeamCity-Agenten
./bin/agent.sh run
