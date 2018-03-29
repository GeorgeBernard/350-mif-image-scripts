# Memory helpers

## Functions
- flattenImage
loads image from filename and "flattens" it to vector of [R, G, B] tuples

- indexImage
using a filename and a colorToIndexMap you can convert the image file to a vector of value indices

- writeMif
takes data vector and configuration variables to write a full mif file

## Scripts
- GenerateColorMap
runs on a list of images and maps unique colors to it

- GenerateImageIndex
test script for image indexer, shows that you can feasibly recreate the image using this minimum mapping

- GenerateMif
generates color mif file (for loading on FPGA directly) and a test image data mif file