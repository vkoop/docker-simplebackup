#!/bin/bash
set -e

if [ "$1" = 'anacron' ]; then
    if [ ! -L "/backup-script/config" ]; then
        echo "Config folder isn't linked yet. Will create a symlink."
        ln -s /backups/config /backup-script/config
    fi
    echo "Will run anacron"
    exec anacron -d -n
fi

exec "$@"
