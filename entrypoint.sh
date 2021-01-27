#!/bin/bash

echo "Upadte server..."
cd /home/steam/ && ./steamcmd.sh +@sSteamCmdForcePlatformType windows +login anonymous +force_install_dir /home/steam/rs2v/ +app_update 418480 validate +quit

echo "Starting server..."
xvfb-run wine64 /home/steam/rs2v/Binaries/Win64/VNGame.exe vnsu-SongBe
echo "Server running..."