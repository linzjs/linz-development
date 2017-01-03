#!/bin/bash

set -e

case "$1" in
    "build")
        exec make html ;;
    "check")
        exec make spelling ;;
    "watch")
        # pwd
        # ls -l ./
        # exec sphinx-build -b html -c ./ ./src _build/html ;;
        make html
        while true; do
            bash -c "inotifywait -e modify -r ./src && make html"
        done
        ;;
    *)
        exec "$@" ;;
esac
