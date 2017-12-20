@echo off

rem [inputFile] [numTopics] [minsup] [thresh] [maxPattern] [gibbsSamplingIterations] [lang] [optimizationBurnIn] [alpha]

set inputFile=%1%
set minsup=%3%
set thresh=%4%
set maxPattern=%5%
set gibbsSamplingIterations=%6%
set topicModel=2

rem Enter "en" for english and "es" for spanish
set lang=%7%

cd TopicalPhrases
echo Data cleaning...
call clean.bat %inputFile% %lang% 

echo Data preparing...
set modFile=rawFiles/cleanText
call win_runDataPreparation.bat %modFile% %lang%

echo Continuous Pattern Mining ... 
call win_runCPM.bat %minsup% %maxPattern% %thresh%

set numTopics=%2%
set optimizationBurnIn=%8%
set alpha=%9%
set optimizationInterval=50

call win_runPhrLDA.bat %topicModel% %numTopics% %gibbsSamplingIterations% %optimizationBurnIn% %alpha% %optimizationInterval%

call win_createUnStem.bat %modFile% %maxPattern% %lang%
python unMapper.py input_dataset\input_vocFile input_dataset\input_stemMapping input_dataset_output\unmapped_phrases input_dataset_output\input_partitionedTraining.txt input_dataset_output\newPartition.txt

copy input_dataset_output\newPartition.txt ..\output\corpus.txt
copy input_dataset_output\input_wordTopicAssign.txt ..\output\topics.txt
rem rmdir input_dataset /s /q
rem rmdir input_dataset_output /s /q

cd ..
cd output
python topPhrases.py
python topTopics.py
move *.txt outputFiles
cd ..
