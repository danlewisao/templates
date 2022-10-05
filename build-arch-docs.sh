#!/bin/bash

# Jem Rayfield
# Process all architecture templates includes
# Convert markdown into pdf
# Convert markdown plantuml code blocks into images

rm -rf ./generated/ && mkdir ./generated
rm -rf ./plantuml-images

for archTemplate in ./*architecture*template.md
do

  generatedFilePath=${archTemplate/-template\.md/\.md}
  generatedFileName=$(basename ${generatedFilePath})
  
  mdOutputFilePath="./generated/${generatedFileName}"
  pdfOutputFilePath=${mdOutputFilePath/\.md/\.pdf}

  echo "processing includes on [${archTemplate}] to markdown [${mdOutputFilePath}] and pdf [${pdfOutputFilePath}]"  

  # Process the includes
  markdown-pp ${archTemplate} -o ${mdOutputFilePath}

  # Convert plantuml code blocks into images
  # Convert markdown into pdf
  #
  # Check the pandoc pdf conversion manual
  #
  # https://pandoc.org/MANUAL.pdf
  pandoc ${mdOutputFilePath} \
    -f markdown-raw_tex \
    --variable=geometry:a4paper,margin=2cm \
    --variable=fontsize:11pt \
    -o ${pdfOutputFilePath} \
    --filter pandoc-plantuml

done
