# Verwende das offizielle TeamCity-Agent-Image als Basis
FROM jetbrains/teamcity-agent:latest

# Installiere Abhängigkeiten
RUN apt-get update && apt-get install -y \
    wget \
    apt-transport-https \
    software-properties-common

# Installiere das Microsoft-Paketrepository und die Schlüssel
RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb

# Aktualisiere die Paketliste und installiere das .NET SDK
RUN apt-get update && apt-get install -y dotnet-sdk-8.0

# Setze die Umgebungsvariable für den Pfad
ENV DOTNET_ROOT=/usr/share/dotnet

# Setze das Arbeitsverzeichnis
WORKDIR /opt/buildagent

# Kopiere die Startskripte für den Agenten
COPY run-agent.sh /opt/buildagent/

# Setze die Ausführungsrechte für das Startskript
RUN chmod +x /opt/buildagent/run-agent.sh

# Startbefehl für den TeamCity-Agenten
CMD ["/opt/buildagent/run-agent.sh"]
