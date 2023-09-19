# escape=`
FROM lacledeslan/steamcmd:linux as colonysurvival-downloader

RUN echo "\n\nDownloading Colony Survival Dedicated Server via SteamCMD"; `
        mkdir --parents /output; `
        /app/steamcmd.sh +force_install_dir /output +login anonymous +app_update 748090 validate +quit;

COPY ./dist/linux /output

#=======================================================================`
FROM debian:bookworm-slim

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

HEALTHCHECK NONE

RUN dpkg --add-architecture i386 &&`
    apt-get update && apt-get install -y `
        ca-certificates locales locales-all software-properties-common tini tmux &&`
    apt-get clean &&`
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*;

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

LABEL maintainer="Laclede's LAN <contact @lacledeslan.com>" `
      com.lacledeslan.build-node=$BUILDNODE `
      org.label-schema.schema-version="1.0" `
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" `
      org.label-schema.vcs-ref=$SOURCE_COMMIT `
      org.label-schema.vendor="Laclede's LAN" `
      org.label-schema.description="Colony Survival Dedicated Server" `
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-colonysurvival"

# Set up Enviornment
RUN useradd --home /app --gid root --system colonysurvival;

COPY --chown=colonysurvival:root --from=colonysurvival-downloader /output /app

RUN chmod +x /app/ll-scripts/* /app/ll-tests/*.sh;

USER colonysurvival

WORKDIR /app

CMD ["/bin/bash"]

ONBUILD USER root
