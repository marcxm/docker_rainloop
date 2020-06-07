#!/bin/bash

apachectl -D FOREGROUND | tee /tmp/docker.log
