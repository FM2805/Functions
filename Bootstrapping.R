
#############################################################################################################
# Bootstrapping Function without for loop
#############################################################################################################

boot_fun <- function(Nbr,df,n_rep) {
  
  # Create the indices for setting cells to NA
  l_sample<-lapply(seq_len(n_rep),Create_Samples)
  l_rep <- as.list(seq_len(n_rep))
  
  # Create the variables globally
  #sapply(seq_len(l_rep[[1]]),function(x) assign(s_var[[x]],l_sample[[x]], envir = .GlobalEnv))
  
  # Save the cols in a list
  l_target <-lapply(1:n_rep, function(x) (df[,x]))
  
  # Apply the NAs to the cols
  randomize <- function(l_cols,l_rand) {
  l_df <- as.matrix(l_cols)
  l_Nas <- as.vector(l_rand)
  l_df[l_Nas] <- NA
  return(l_df)
  }
  
  # Get the date with the NAs
  DF_Fc_adj<-data.frame(mapply(randomize,l_target,l_sample))
  # Calculate rowmen for the fc period
  DF_Fc_adj <- DF_Fc_adj[121:228,]
  
  Mean_Rows<-rowMeans(DF_Fc_adj,na.rm=T)
  Sum_Rows <- sum(Mean_Rows,na.rm=TRUE)
  
  return(Sum_Rows)
}

l_rep <- list(length(indices))
l_Number <- as.list(1:100)
l_DF <- list(DF_FC)

reps <- mapply(boot_fun,l_Number,l_DF,l_rep)
Prog <- lapply(reps,sum)
Prog <- unlist(Allzeit)
Intervall <- quantile(Prog,probs=c(0.95,0.05))
