#!/bin/bash

# Check if vbmeta.img exists
if [ -f vbmeta.img ]; then
    echo "Found vbmeta.img, proceeding with signing."

    # Generate a signing key if it doesn’t already exist
    if [ ! -f phh.pem ]; then
        openssl genrsa -out phh.pem 4096
    fi

    # Set rollback index to match device revision (0xc = 12 in decimal)
    python3 ./avbtool make_vbmeta_image --key phh.pem --algorithm SHA256_RSA4096 --flag 2 --padding_size 4096 --rollback_index 12 --output vbmeta-signed.img

    echo "Signing complete. Output saved as vbmeta-signed.img."
else
    echo "Error: vbmeta.img not found."
    exit 1
fi
