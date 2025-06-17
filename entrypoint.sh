#!/bin/bash
set -e

if [ "$1" = 'backup' ]; then
    if [ ! -L "/backup-script/config" ]; then
        echo "Config folder isn't linked yet. Will create a symlink."
        ln -s /backups/config /backup-script/config
    fi
    echo "Running backup..."
    /bin/bash /backup-script/setup_ssh.sh
    /bin/bash /backup-script/backup_all_servers.sh
    echo "Backup completed."
    exit 0
fi

exec "$@"
