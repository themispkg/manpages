#!/bin/bash

gitpage="https://themispkg.github.io"

repname="$(filename $(cat .git/config | grep url | awk '{print $3}'))"

command -v man2html &> /dev/null || exit 1 # check if man2html exist

for i in $(find . -not -path '*/.*' -type f -name '*.sh.*') ; do
    dirname="$(realpath $(dirname "${i}"))"
    fname="$(filename ${i%.*})"
    man2html "$(realpath ${i})" > "${dirname}/${fname%.*}.html"
done

cat - > index.html <<HEAD
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${repname}</title>
<style>  
hr {  
    width: 80%;  
    height: 2px;  
    background-color: red;  
    margin-bottom: 5px;  
    margin-right: auto;  
    margin-left: auto;  
    margin-top: 6px;  
    border-width: 2px;  
    border-color: blue;  
}
</style>  
</head>
<body>
<center><h1>index of ${repname}:</h1></center>
<hr>
<center>
HEAD

for x in $(find . -not -path '*/.*' -type f -name '*.html' | sed 's/^.//') ; do
    echo -n "<a href='.${x}'>${gitpage}/${repname}${x}</a><br>" >> index.html
done

cat - >> index.html <<ENDOFTAGS
</center>
<hr>
<center>
this project is fully open source and uses GNU Public license V3 so you can find the source codes in <a href="$(cat .git/config | grep url | awk '{print $3}')">${repname}</a><br>
project web page:<a href="${gitpage}"> themis</a> / current maintainer: <a href="https://github.com/lazypwny751">lazypwny751</a><br>
<b>$(date +%d-%m-%Y)</b> - <b>lazypwny751</b>
</center>
</body>
</html>
ENDOFTAGS