#!/bin/bash
/usr/local/bin/docker run --rm --cap-drop=all --security-opt="no-new-privileges" --disable-content-trust -u "nobody" -v /etc/localtime:/etc/localtime:ro -v /dev/log:/dev/log  --name speedtest -t speedtest:latest

