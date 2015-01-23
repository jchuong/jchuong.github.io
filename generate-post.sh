#!/bin/bash

DATE=`date "+%Y-%m-%d-"`
echo "What is the title of the post?"
read TITLE
echo "What should the file be named?"
read FILENAME
echo "File will be called $DATE$FILENAME.md"

FILE="./_posts/$DATE$FILENAME.md"
touch $FILE
echo "\
---
layout: post
title: $TITLE
tags:
published: false
---" > $FILE
