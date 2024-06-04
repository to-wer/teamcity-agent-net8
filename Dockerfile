# Verwende das offizielle TeamCity-Agent-Image als Basis
FROM jetbrains/teamcity-agent:latest

# Installiere das .NET 8 SDK
RUN wget https://dotnetcli.azureedge.net/dotnet/Sdk/8.0.100/dotnet-sdk-8.0.100-linux-x64.tar.gz -O dotnet-sdk.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet-sdk.tar.gz -C /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && rm dotnet-sdk.tar.gz

# Setze die Umgebungsvariable für den Pfad
ENV DOTNET_ROOT=/usr/share/dotnet

# Setze den Arbeitsverzeichnis und kopiere die Konfigurationsdatei
WORKDIR /data/teamcity_agent/conf

# Kopiere die Konfigurationsdateien (falls nötig)
COPY your-config-file.xml /data/teamcity_agent/conf/buildAgent.properties

# Startbefehl für den TeamCity-Agenten
CMD ["/run-services.sh"]
