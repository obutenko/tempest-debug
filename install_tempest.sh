#!/bin/bash -xe
pip install tempest==16.0.0
source /home/rally/keystonercv3
rally db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest \
    --name tempest-verifier \
    --version 16.0.0 \
    --system-wide
rally verify configure-verifier --extend /home/rally/tempest.conf
rally verify configure-verifier --show
