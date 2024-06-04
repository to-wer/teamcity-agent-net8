# Verwende das offizielle TeamCity-Agent-Image als Basis
FROM jetbrains/teamcity-agent:latest

# Installiere Abhängigkeiten
RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https \
    software-properties-common

# Installiere das Microsoft-Paketrepository und die Schlüssel
RUN curl -sSL https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -o packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb

# Aktualisiere die Paketliste und installiere das .NET SDK
RUN apt-get update && apt-get install -y dotnet-sdk-8.0

# Setze die Umgebungsvariable für den Pfad
ENV DOTNET_ROOT=/usr/share/dotnet

# Setze den Arbeitsverzeichnis und kopiere die Konfigurationsdatei
WORKDIR /data/teamcity_agent/conf

# Kopiere die Konfigurationsdateien (falls nötig)
#COPY your-config-file.xml /data/teamcity_agent/conf/buildAgent.properties

# Startbefehl für den TeamCity-Agenten
CMD ["/run-services.sh"]
