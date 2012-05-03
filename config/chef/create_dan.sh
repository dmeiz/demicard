useradd dan -g admin -d /home/dan -m -s /bin/bash && \
mkdir /home/dan/.ssh && \
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArX70wa36G5s1RnD4/Wnd3h2Dk4vUZsIXOkFxgmZY2SGvy6nRsMdwxouIXjC/v4UPaJjTvKJS3j1M6Qj9JvAW5hM5V9tOMLAOXQPikj2prMgYTjG3gIRCj9GEfNQn7kbwatemNBokwJ/jkoqRLyVe9bm5s/OR+TUcGL+2PdcynXzQFBFY++/e2HUtFwCk3t4oI6k9M+jlmA6WNKrHK32mcYowhp5rguyuRDATOtrx1UrrEHhrxwiNwVNGd7U+0B0Vr/3xAJjom2Sn0NzGxFMGa+Y3MDsylzhqHXQcpsr3o9TtXXWqrp7qehvSBYO84fR/Y2f+srVxwmF4tyNqHHPoOw== dan@Dan-Hensgens-MacBook-Pro.local' > /home/dan/.ssh/authorized_keys && \
chown -R dan.admin /home/dan/.ssh && \
chmod 700 /home/dan/.ssh && \
chmod 600 /home/dan/.ssh/authorized_keys
