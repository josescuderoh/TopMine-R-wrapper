topmine <- function(path, numTopics, minsup, par_lst = list()){
  currwd <- getwd()
  #Open the folder
  setwd("TopMine")
  
  toSTR <- function(v1) {
    deparse(substitute(v1))
  }
  
  ########## Read parameters ##########
  #Path to file
  path <- as.character(path)
  #Number of topics k
  numTopics <- as.character(numTopics)
  #Minimum support
  minsup <- as.character(minsup)
  #Significance threshold
  if(!is.null(get0("par_lst")$thres))thres <- as.character(par_lst$thres) else thres = 4
  #Max pattern
  if(!is.null(get0("par_lst")$maxPattern)) maxPattern <- as.character(par_lst$maxPattern) else maxPattern = 3
  #Number of Gibbs sampling iteration
  if(!is.null(get0("par_lst")$gibbsSamplingIterations)) gibbsSamplingIterations <- as.character(par_lst$gibbsSamplingIterations) else gibbsSamplingIterations = 1000
  #Language (es or en)
  if(!is.null(get0("par_lst")$lang)) lang <- as.character(par_lst$lang) else lang = "en"
  #Optimization burn in iterations
  if(!is.null(get0("par_lst")$optimizationBurnIn)) optimizationBurnIn <- as.character(par_lst$optimizationBurnIn) else optimizationBurnIn = 5
  #Alpha
  if(!is.null(get0("par_lst")$alpha)) alpha <- as.character(par_lst$alpha) else alpha = 2
  
  ########## Build string ##########
  #Build pattern
  pat <- paste(path, numTopics, minsup, thres, maxPattern, gibbsSamplingIterations, lang, optimizationBurnIn, alpha, sep = " ")
  
  #Create batch pattern
  batch_cmd <- paste("auto_win_run.bat",pat, sep = " ")
  print(batch_cmd)
  
  #Run batch
  shell(batch_cmd)

  #Read results file
  topicPhrases <- read.table("output/outputFiles/topicalPhrases.txt", header = F, sep = "\t")
  sorted <- by(data = topicPhrases, INDICES = topicPhrases[,1], function (set) {
    set[order(set[,3], decreasing = T),][1:10,]})

  sorted.df <- data.frame(Pos =1:10); name <- numeric(length = length(sorted))
  i<- 1
  for(topic in sorted){
    name[i] <- max(topic[,1])
    most <- topic[,2]
    sorted.df <- cbind(sorted.df,most)
    i<- i +1
  }
  names(sorted.df)[2:ncol(sorted.df)] <- name

  #Return to parent directory
  setwd(currwd)

  return(sorted.df)
}



