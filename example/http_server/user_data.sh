#!/bin/bash
sudo dnf -y update

## Apache Setup
sudo dnf -y install httpd
sudo systemctl start httpd.service