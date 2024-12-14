# Colony Survival Dedicated Server in Docker

## Linux Image

[![linux/amd64](https://github.com/LacledesLAN/gamesvr-colonysurvival/actions/workflows/build-linux-image.yml/badge.svg)](https://github.com/LacledesLAN/gamesvr-colonysurvival/actions/workflows/build-linux-image.yml)

docker run --net=host -it --rm lacledeslan/gamesvr-colonysurvival /app/colonyserver.x86_64 -batchmode -nographics +server.networktype LAN +server.world ZEST
