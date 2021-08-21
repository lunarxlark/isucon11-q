#!/bin/bash

wget https://github.com/tkuchiki/alp/releases/download/v1.0.4/alp_linux_amd64.zip -O alp.zip && unzip alp.zip && sudo install ./alp /usr/local/bin && rm alp alp.zip