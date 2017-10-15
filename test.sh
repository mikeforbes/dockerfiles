#!/bin/bash
set -e
files=`ls */Dockerfile|cut -d"/" -f1`

for f in $files; do
        cd $f
	docker build -t $f:latest .
        cd ..
	echo "                       ---                                   "
	echo "Successfully built $f"
	echo "                       ---                                   "
done
