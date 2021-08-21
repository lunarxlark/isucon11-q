#!/bin/bash

sudo apt-get install -y percona-toolkit

# How to useage
# $ sudo pt-query-digest /var/log/mysql/slow.log > /home/isucon/isucon11-q/slow.txt
# $ chown isucon:isucon slow.txt