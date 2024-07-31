#!/usr/bin/env sh

echo "Cleaning directories..."
rm -rf bin dist

echo "Build..."
npx tsc

echo "Creating the dist directory if it doesn't exist..."
mkdir -p bin

echo "Building the blob file..."
node --experimental-sea-config sea-config.json 

echo "Creating the binary from nodejs install..."
cp $(command -v node) ./bin/macports 

echo "Removing the signature..."
codesign --remove-signature ./bin/macports 

echo "Injecting the blob into the node executable..."
npx postject ./bin/macports NODE_SEA_BLOB ./bin/sea-prep.blob \
    --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2 \
    --macho-segment-name NODE_SEA 

echo "Re-signing the executable..."
codesign --sign - ./bin/macports 