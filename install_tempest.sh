#!/bin/bash -xe
pip install tempest==16.0.0
rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest \
    --name tempest-verifier \
    --version 16.0.0 \
    --system-wide
rally verify configure-verifier --extend /home/rally/tempest_conf
rally verify configure-verifier --show
