#!/bin/bash -e

mkdocs build
tar cvf /tmp/site.tar ./site/*
scp /tmp/site.tar www.syssec.org:/tmp/
rm /tmp/site.tar
ssh root@www.syssec.org /root/bin/deploy.sh

