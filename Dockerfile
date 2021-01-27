FROM ubuntu:latest

LABEL maintainer="rs2v"

ENV USER steam
ENV HOMEDIR "/home/${USER}"
ENV STEAMAPPID 418480 
ENV STEAMAPP rs2v
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}"
ENV DLURL https://heldendesbildschirms.dynv6.net/

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get install xvfb -y && dpkg --add-architecture i386 && apt-get update -y && apt-get install wine64 -y && apt-get install lib32gcc1 -y && apt-get install wget -y && apt-get install curl -y

#RUN useradd --home-dir /home/steam --create-home steam

RUN mkdir /home/steam && mkdir /home/steam/rs2v/

ADD entrypoint.sh /home/steam/
RUN chmod 755 /home/steam/entrypoint.sh

RUN cd /home/steam/ && wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && tar -xvzf steamcmd_linux.tar.gz
	
ENV SRCDS_FPSMAX=300 \
	SRCDS_AdminName=admin \
	SRCDS_AdminPassword= \
	SRCDS_MaxPlayers=64 \
	SRCDS_PORT=7787 \
	SRCDS_QueryPort=27015 \
	SRCDS_WebAdminPort=8080 \
	SRCDS_Multihome=0.0.0.0 \
	SRCDS_PREFERREDPROCESSOR=2 \
	ConfigSubDir=""


VOLUME /home/steam/rs2v/

WORKDIR /home/steam/

CMD ["bash"]

ENTRYPOINT ["/home/steam/entrypoint.sh"]

# Expose ports
EXPOSE 7787/tcp \
	27015/udp \
	8080/udp