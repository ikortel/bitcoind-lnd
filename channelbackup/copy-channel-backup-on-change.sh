#!/bin/bash
#while true; do
#    inotifywait /root/.lnd/
#    gsutil cp -r /root/.lnd/. gs://prs-internal-services-lnd-channel-backups/backup/.lnd
#done

while true; do
    inotifywait /root/.lnd/data/chain/bitcoin/testnet/channel.backup
    gsutil cp /root/.lnd/data/chain/bitcoin/testnet/channel.backup gs://prs-internal-services-lnd-channel-backups/channel.backup
done