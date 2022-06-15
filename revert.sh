#!/bin/sh
for file in ??.*.m4a; do mv "$file" "${file:4}"; done
for file in */??.*.m4a; do mv "$file" "${file:4}"; done
