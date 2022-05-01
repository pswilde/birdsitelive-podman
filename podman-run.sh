#!/bin/bash

podman pod create --name birdsitelive-pod \
	-p 5000:80 

podman run -d \
	--pod birdsitelive-pod \
	--name birdsitelive_db \
        -e POSTGRES_USER=birdsitelive \
        -e POSTGRES_PASSWORD=birdsitelive \
        -e POSTGRES_DB=birdsitelive \
        -v ./postgres:/var/lib/postgresql/data \
        postgres:9.6

podman run -d \
	--pod birdsitelive-pod \
        --name birdsitelive \
        -e Instance:Domain=your.base.url \
        -e Instance:AdminEmail=admin@email.address \
        -e Db:Type=postgres \
        -e Db:Host=localhost \
        -e Db:Name=birdsitelive \
        -e Db:User=birdsitelive \
        -e Db:Password=birdsitelive \
        -e Twitter:ConsumerKey=YOURTWITTERCONSUMERKEY \
        -e Twitter:ConsumerSecret=YOURTWITTERCONSUMERSECRET \
        -e Moderation:FollowersBlackListing=none \
        -e Moderation:TwitterAccountsBlackListing=none \
        nicolasconstant/birdsitelive:edge

