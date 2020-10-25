#!/bin/bash
cat $1 | sed 's|.\+(\([0-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\))$|ipq\1|g' | grep ipq | sed 's|ipq||'
