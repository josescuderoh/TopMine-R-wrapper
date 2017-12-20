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

### Using topmine

The complete repository must copied in order to use the algorithm. It contains most of the files provided by the authors.

For spanish:
```r
topic <- topmine(path, numTopics, minsup, par_lst)
```

path = path to txt file containing the corpus
numTopics = number of topics
minsup = minimum support
par_lst = list with more parameters for the algorithm: thres (significance threshold) default to 4; maxPattern (maximum length of the pattern) default to 3; gibbsSamplingIterations (Number of Gibbs sampling iteration) default to 1000; lang (language of the text- "en" or "es") defailt to "en"; optimizationBurnIn (optimization burn in iterations) default to 5; alpha (algorithm parameter) default to 2.

`topmine` returns a dataframe with all `numTopics` topics ordered in columns.




#Run function
topic <- topmine(path = "C:/Users/jescudero/Documents/New/pacto.txt",7,30, par_lst = list(lang = "es"))


dataset <- read.table("TopMine/output/outputFiles/topicalPhrases.txt", header = F, sep = "\t")
sorted <- by(data = dataset, INDICES = dataset[,1], function (set) {
  set[order(set[,3], decreasing = T),][1:10,]
}
)
sorted.df <- data.frame(Pos =1:10); name <- numeric(length = length(sorted))
i<- 1
for(topic in sorted){
  name[i] <- max(topic[,1])
  most <- topic[,2]
  sorted.df <- cbind(sorted.df,most)
  i<- i +1
}
names(sorted.df)[2:ncol(sorted.df)] <- name
View(sorted.df)
