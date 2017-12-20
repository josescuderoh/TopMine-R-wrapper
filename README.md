## R Wrapper for TopMine Algorithm

This repo contains a wrapper for the Java implementation of the TopMine algorithm created by El-Kishky and available at http://web.engr.illinois.edu/~elkishk2/. More details about the algorithm and the authors can be found in 

@inproceedings{conf/vldb/ElkishkySWVH13,
  author    = {Ahmed El-Kishky and
		Yanglei Song and
		Chi Wang and
		Clare R. Voss and
		Jiawei Han},
  title     = {Scalable Topical Phrase Mining from Text Corpora},
  booktitle = {VLDB},
  year      = {2015},
}

If you use any contents in this package, please cite the above paper as your reference.

### Now in spanish

The Java scripts have been modified to accept spanish and english corpora. Hence this algorithm can be used for both languages using R and Java. Two examples were added in order to test the algorithm.

Note: this implementation will only work in Windows. Changes to the .bash file in http://web.engr.illinois.edu/~elkishk2/ must me carried out if using in different OS.

### Using TopMine

The complete repository must copied in order to use the algorithm. It contains most of the files provided by the authors.


### Running the algorithm

```r
topic <- topmine(path, numTopics, minsup, par_lst)
```

path = path to txt file containing the corpus
numTopics = number of topics
minsup = minimum support
par_lst = list with more parameters for the algorithm: thres (significance threshold) default to 4; maxPattern (maximum length of the pattern) default to 3; gibbsSamplingIterations (Number of Gibbs sampling iteration) default to 1000; lang (language of the text- "en" or "es") defailt to "en"; optimizationBurnIn (optimization burn in iterations) default to 5; alpha (algorithm parameter) default to 2.

`topmine` returns a dataframe with all `numTopics` topics ordered in columns.

### Reading output files

The implementation by El-Kishky writes several txt files with the results of running the algorithm. Such are the following:

**TopMine/output/outputFiles/topicalPhrases.txt**: topic phrases extracted.
**TopMine/output/outputFiles/topPhrases.txt**: most frequent phrases.
**TopMine/output/outputFiles/topics.txt**: topics to all documents.
**TopMine/output/outputFiles/corpus.txt**: tidy documents.

## Example

```r
#Path to corpus
path2file <- paste(getwd(), "example_en.txt", sep ="/")

#Run topmine
topic <- topmine(path = path2file, numTopics = 15 ,minsup = 30, par_lst = list(lang = "en"))

#Read topical phrases
dataset <- read.table("TopMine/output/outputFiles/topicalPhrases.txt", header = F, sep = "\t")

```