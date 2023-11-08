#!/bin/bash
wget https://geojackass.com/jageocoder/latest/jukyo_all_v21.zip.tar.xz &
pid1=$!
wait $pid1
tar -Jxvf jukyo_all_v21.zip.tar.xz &
pid2=$!
wait $pid2
jageocoder install-dictionary jukyo_all_v21.zip &
pid3=$!
wait $pid3
jageocoder get-db-dir
rm jukyo_all_v21.zip.tar.xz
rm jukyo_all_v21.zip