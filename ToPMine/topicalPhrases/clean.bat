@echo off
echo Running script to clean text
set inputFile=%1%
set binFolder=bin
set jarFolder=lib\*
set classpath=%binFolder%;%jarFolder%
set className=DataPreparation.CleanText
set startsWithID=1
set sel_lang=%2%

rem Choose language
if %sel_lang%==en (
	set stopwordFile=stoplists\en.txt
	echo Language selected is english
)
if %sel_lang%==es (
	set stopwordFile=stoplists\es.txt
	echo Language selected is spanish
)

java -Xmx8g -cp %classpath%  %className% %inputFile% %lang% %stopwordFile%