FROM debian:buster

VOLUME ["/root/.lnd"]

COPY copy-channel-backup-on-change.sh /root/
COPY auth.json /root/auth.json

RUN cd /root \
&&  mkdir backup \
&&  mkdir backup/.lnd \
&&  apt update \
&&  apt install inotify-tools -y \
&&  chmod +x /root/copy-channel-backup-on-change.sh

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
&&  apt-get install apt-transport-https ca-certificates gnupg -y \
&&  apt-get install curl -y \
&&  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
&&  apt-get update && apt-get install google-cloud-sdk -y \
&&  gcloud auth activate-service-account --key-file=/root/auth.json

ENTRYPOINT ["/bin/sh","/root/copy-channel-backup-on-change.sh"]