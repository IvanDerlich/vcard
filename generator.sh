#!/bin/bash

# Check if a VCF file path is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <path-to-vcf-file>"
	exit 1
fi

VCF_PATH="$1"
BASENAME=$(basename "$VCF_PATH" .vcf)
OUTPUT_DIR="output"
OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}_qr.png"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"


# Check if qrencode is installed
if ! command -v qrencode >/dev/null 2>&1; then
	echo "Error: 'qrencode' is not installed."
	echo "Please install it using your package manager (e.g., sudo apt-get install qrencode) and try again."
	exit 2
fi

# Generate QR code
qrencode -l M -s 20 -o "$OUTPUT_FILE" < "$VCF_PATH"

# Check if output file was created
if [ -f "$OUTPUT_FILE" ]; then
	echo "QR code generated successfully: $OUTPUT_FILE"
else
	echo "Error: QR code was not created."
	exit 3
fi