#!/bin/bash

# Check if the vbmeta.img exists
if [ -f vbmeta.img ]; then
    echo "Found vbmeta.img, proceeding with signing."

    # Generate a signing key if it doesn’t already exist
    if [ ! -f phh.pem ]; then
        openssl genrsa -out phh.pem 4096
    fi

    # Sign vbmeta.img with the generated key
    python3 ./avbtool make_vbmeta_image --key phh.pem --algorithm SHA256_RSA4096 --flag 2 --padding_size 4096 --output vbmeta-signed.img --chain_partition vbmeta:vbmeta.img

else
    echo "Error: vbmeta.img not found."
    exit 1
fi
