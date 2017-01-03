#!/bin/bash

set -e

case "$1" in
    "build")
        exec make html ;;
    "check")
        exec make spelling ;;
    "watch")
        make html
        while true; do
            bash -c "inotifywait -e modify -r ./src && make html"
        done
        ;;
    *)
        exec "$@" ;;
esac
