#!/bin/bash

echo "Transferring files from client1 to client2 VM..."
scp copy_this_file_to_client_1 ubuntu@172.31.86.12:/home/ubuntu/
scp copy_this_file_to_client_2 ubuntu@172.31.93.33:/home/ubuntu/
echo "Files copied successfully"

