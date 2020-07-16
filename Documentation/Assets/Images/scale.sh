#!/usr/bin/env bash

find -iname "*.jpg" -a ! -iname "*-scaled.jpg" |
while read _filename
do
    convert "$_filename" -scale 320x320 "$(basename "$_filename" .jpg)-scaled.jpg"
done

