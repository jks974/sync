FROM jks974/baseimage

# Install required packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y curl

# Create sync user. Test uid = user host
RUN useradd --system --uid 1000 -M --shell /usr/sbin/nologin sync_user

#Download sync
RUN curl -o /usr/bin/btsync.tar.gz https://download-cdn.getsync.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz
RUN cd /usr/bin && tar -xzvf btsync.tar.gz && rm btsync.tar.gz

USER sync_user

VOLUME ["/data"]
VOLUME ["/config"]
EXPOSE 6880
EXPOSE 8888

ENTRYPOINT ["btsync"]
CMD ["--config", "/config/sync.config", "--nodaemon"]