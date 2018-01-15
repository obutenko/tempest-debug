#!/bin/bash -xe
pip install tempest==17.2.0
source /home/rally/keystonercv3
rally db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest \
    --name tempest-verifier \
    --version 17.2.0 \
    --system-wide
rally verify configure-verifier --extend /home/rally/tempest.conf
rally verify configure-verifier --show
git clone https://github.com/openstack/heat-tempest-plugin
pip intall -r /home/rally/heat-tempest-plugin/test-requirements.txt
rally verify add-verifier-ext --source /home/rally/heat-tempest-plugin
