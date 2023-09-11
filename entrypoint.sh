#!/bin/bash
set -e

rm -f /nk-jobboard/tmp/pids/server.pid

exec "$@"
