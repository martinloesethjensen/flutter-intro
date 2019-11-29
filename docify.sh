#!/bin/bash

claat export README.md

CODELAB_FOLDER="flutter-introduction-workshop"

mv $CODELAB_FOLDER docs

cd docs

cd $CODELAB_FOLDER

mv img ..
mv codelab.json ..
mv index.html ..

cd ..

rm -r $CODELAB_FOLDER
