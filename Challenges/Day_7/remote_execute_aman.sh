#!/bin/bash

echo "Executing commands on Client 1"
ssh ubuntu@172.31.86.12 $1


echo "Executing commands on Client 2"
ssh ubuntu@172.31.93.33 $1
