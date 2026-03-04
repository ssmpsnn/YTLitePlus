#!/bin/bash

# Direct IPA download link
IPA_URL="https://files.catbox.moe/uin8nt.ipa"
DOWNLOADED_IPA="YouTube.ipa"

echo "==> Downloading decrypted YouTube IPA..."
curl -L -o $DOWNLOADED_IPA $IPA_URL

if [ ! -f "$DOWNLOADED_IPA" ]; then
    echo "❌ Failed to download IPA"
    exit 1
fi

echo "==> Starting build..."
make package THEOS_PACKAGE_SCHEME=rootless IPA="$DOWNLOADED_IPA" FINALPACKAGE=1

if [[ $? -eq 0 ]]; then
  echo "✅ Build successful"
  shasum -a 256 packages/*.ipa
else
  echo "❌ Failed building YTLitePlus"
  exit 1
fi
