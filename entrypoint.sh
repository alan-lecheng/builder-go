#!/bin/bash
# entrypoint.sh 範例
if [ ! -f .runner ]; then
    ./config.sh --url https://github.com/lechengwork \
    --token ${REGISTRATION_TOKEN} \
    --name $(hostname) \
    --runnergroup test \
    --unattended
fi

./run.sh