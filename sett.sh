#!/bin/bash

set -e

ls -ltr

touch example.txt

echo " before wrong command"

lssdd

touch file.txt

echo " after wrong commadn "