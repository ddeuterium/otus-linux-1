occurences=`grep $keyword $scanFile | wc -l`
echo "DateTime:" `date` "File: ${scanFile}, keyword: ${keyword}, occurences: ${occurences}" >> $outputFile
