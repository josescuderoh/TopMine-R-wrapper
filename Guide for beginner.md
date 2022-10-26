## For beginner

As a green hand, who wants to try the TopMine algorithm in R
- unfamiliar with java or c++
- little information about TopMine online, and http://web.engr.illinois.edu/~elkishk2/ is a 404 error.

This TopMine-R-wrapper is the first choice, essentially, there are some problems in running the algorithm.
- system environment, install JAVA and Python, etc.
- missing some .class files
- ...

It's my personal experience of how to run it successfully in 2022.  Maybe, it can help someone avoid being stuck for a long time.

## 1. System environment

- Window 10
- JAVA(MALLET, GNU, ORG)
- Python
- R/RStuido


### 1.1 JAVA

#### 1.1.1 install JAVA, MALLET, ANT
search "install MALLET WINDOWS" Keywords online to get more detail

**1.1.1.1 JAVA**

- DOWNLOAD :https://www.oracle.com/java/technologies/downloads/

  *I USE version 19*

**1.1.1.2 MALLET**

> MALLET is a Java-based package for statistical natural language processing, document classification, clustering, topic modeling, information extraction, and other machine learning applications to text.

- DOWNLOAD: https://mallet.cs.umass.edu/download.php
- Extract it to the `C:/`
- rename `mallet-xxx` to `mallet`

*I USE VERSION 2.0.8*

**1.1.1.3 Apache Ant**

> Apache Ant is a Java library and command-line tool that help building software

- DOWNLOAD: https://ant.apache.org/bindownload.cgi

  Extract it to the `C:/Program Files`

*I USE VERSION 1.10.12*


#### 1.1.2 SET Environment Variables

`Computer\Control Panel\System and Security\System\Advanced system setting`

`System Properties\Environment Variables`

 **1.1.2.1 JAVA** 

**- New add:** 

variable name: `JAVA_HOME`
variable value: `C:\Program Files\Java\jdk-19\bin`

**- `Path`  > Edit > New add**

`C:\Program Files\Java\jdk-19\bin`

note: `jdk-xx`,  local version  

 **1.1.2.2 Mallet** 

**- New add:**

variable name: `MALLET_HOME`
variable value: `C:\mallet`

**- `Path`  > Edit > New add**

`%MALLET_HOME%\bin`

**- `classpath`  > Edit > New add **

`MALLET_HOME%/class;%MALLET_HOME%lib;%MALLET_HOME%/lib/mallet-deps.jar`

note: if there's no `classpath` , create one . 

**1.1.2.3 Mallet** 

**- New add:**

variable name: `ANT_HOME`
variable value: `C:\Program Files\apache-ant`

**- `Path`  > Edit > New add**

`%ANT_HOME%\bin`

**- `classpath`  > Edit > New add **

`%ANT_HOME%lib`

note:  `variable value` of  `classpath` are delimited by ";" 



### 1.2 Python

search "install python WINDOWS" Keywords online to get more detail

#### 1.2.1 install Python

Download: https://www.python.org/downloads/

*I USE VERSION 3.10.8*

#### 1.2.2 SET Environment Variables

**- `Path`  > Edit > New add 2 Variables **

`C:\Program Files\Python310\Scripts`

`C:\Program Files\Python310`

note: `Pythonxxx`,  local version  

### 1.3 R/RStudio

search "install R WINDOWS" Keywords online to get more detail



## 2. get .class files

 **these files are updated to  `..\TopMine-R-wrapper\ToPMine\topicalPhrases\bin`**

 WHY & HOW, as follows 

 run in R , it throw errors: 

```
java.lang.NoClassDefFoundError: cc/mallet/types/Dirichlet
java.lang.NoClassDefFoundError: cc/mallet/pipe/Pipe
....
java.lang.NoClassDefFoundError: gnu/trove/TObjectIntHashMap
....
java.lang.NoClassDefFoundError: org/tartarus/snowball/ext/englishStemmer
....
```

### 2.1 mallet

**compile MALLET with Apache Ant**

- run CMD
- type `cd c:\mallet`,  press Enter
- type `ant`, press Enter

```
C:\Users\user>cd c:\mallet

c:\mallet>ant
Buildfile: c:\mallet\build.xml

init:
     [copy] Copying 1 file to c:\mallet\class

compile:
    [javac] c:\mallet\build.xml:62: warning: 'includeantruntime' was not set, defaulting to build.sysclasspath=last; set to false for repeatable builds

BUILD SUCCESSFUL
Total time: 1 second
```

**Copy folder to  TopMine-R-wrapper**

- Copy `C:\mallet\class\cc`

- Paste to`..\TopMine-R-wrapper\ToPMine\topicalPhrases\bin`

note: in this repo,  `bin` contains `cc` folder

### 2.2 gnu/trove

Download: https://trove4j.sourceforge.net/html/overview.html

**select  the old release version : trove-2.1.0.tar.gz**

note: some files or paths have been changed in higher version

**uncompress and copy folder to  TopMine-R-wrapper**

- Copy : `..\trove-2.1.0\lib\trove-2.1.0.jar\gnu`

- Paste to`..\TopMine-R-wrapper\ToPMine\topicalPhrases\bin`

note: in this repo,  `bin` contains `gnu` folder

### 2.3 Snowball 

Download: http://snowball.tartarus.org/download.html

**compile **

- Copy : `..\org`

- Paste to`..\TopMine-R-wrapper\ToPMine\topicalPhrases\bin`

note: in this repo,  `bin` contains `org` folder

## 3. Run in R

hope it was useful

