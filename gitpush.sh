#!/bin/bash

find ./ -type f -name '*~' -delete
find ./ -type f -name '*\#*' -delete
find ./ -type f -name '.\#*' -delete
find ./ -type l -name '.#*' -delete

git add * -v
git commit -m upd
git push
