
set binFolder=bin
set jarFolder=lib\*
set classpath=%binFolder%;%jarFolder%

set parFile=input_dataset_output\input_partitionedTraining.txt
set canFile=input_dataset_output\candidate

set vocFile=input_dataset\input_vocFile
set rawFile=%1%
set outFile=input_dataset_output\unmapped_phrases
set maxPattern=%2%
set sel_lang=%3%

set className=unStem.CandidatePhraseGen
java -Xmx4g -cp %classpath%  %className% %parFile% %canFile%

rem Choose language
if %sel_lang%==en (
	set stopwordFile=stoplists\en.txt
	set className=unStem.UnStemPhraseClass_en
)
if %sel_lang%==es (
	set stopwordFile=stoplists\es.txt
	set className=unStem.UnStemPhraseClass_es
)

java -Xmx6g -cp %classpath%  %className% %canFile% %stopWordFile% %vocFile% %rawFile% %outFile% %maxPattern%