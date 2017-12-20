@echo off

set inputFile=%1%
set binFolder=bin
set jarFolder=lib\*
set classpath=%binFolder%;%jarFolder%

set datasetName=input
set minsup=3
set startsWithID=1
set className=DataPreparation.PrepareData
set sel_lang=%2%

rem Choose language
if %sel_lang%==en (
	set stopwordFile=stoplists\en.txt
)
if %sel_lang%==es (
	set stopwordFile=stoplists\es.txt
)

java -Xmx8g -cp %classpath%  %className% %inputFile% %datasetName% %minsup% %startsWithID% %stopwordFile% %sel_lang%

set className=DataPreparation.PreparePartitionFile
java -Xmx8g -cp %classpath%  %className% %inputFile% %datasetName% %startsWithID%