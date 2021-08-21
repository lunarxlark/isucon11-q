#!/bin/bash
GOOS=linux go build
scp ./sql i11-3:/home/isucon/
