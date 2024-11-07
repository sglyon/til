---
date: '2024-11-07T08:39:22-05:00'
draft: false
title: 'Persistent SSH Port Forwarding'
tags: ["unix"]
---

I found myself in a scenario where I needed to be able to run a script on a remote server that would connect to an RDS Postgres instance only exposed to a jump server.

The computers involved are:

1. My client machine
2. My remote server
3. The jump server
4. The RDS instance

I ended up setting up a persistent ssh tunnel on the remote server using systemd.

The unit file is as follows:

```ini
[Unit]
Description=Persistent SSH Tunnel to from port 9092 on this server to port 9090 on external server (for encrypted traffic)
After=network.target

[Service]
Restart=on-failure
RestartSec=5
User=sglyon
ExecStart=/usr/bin/ssh -NT -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes -i /home/sglyon/.ssh/id_rsa -L LOCAL_PORT:RDS_URL:RDS_PORT JUMP_SERVER_USER@JUMP_SERVER

[Install]
WantedBy=multi-user.target
```

Note that in `ExecStart` I replaced anything sensitive with placeholders.

I chose to use my user (`sglyon`) because that user has access to the private ssh key needed to connect to the jump server.

With this unit file in place I did ran

```shell
sudo systemctl daemon-reload
sudo systemctl enable --now ssh-tunnel.service
```

and I was up and running.

Now I can run a command like `psql -h localhost -p 54321 -U dbuser -d dbname` on my remote server and it will connect to the RDS instance through the jump server.
