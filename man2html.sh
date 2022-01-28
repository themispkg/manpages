#!/bin/bash

command -v man2html &> /dev/null || exit 1 # check if man2html exist

for i in $(find . -not -path '*/.*' -type f -name '*.sh.*') ; do
    dirname="$(realpath $(dirname "${i}"))"
    fname="$(filename ${i%.*})"
    man2html "$(realpath ${i})" > "${dirname}/${fname%.*}.html"
done