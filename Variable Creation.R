########################
# Basic code for creating variable names (without assigning them) while avoiding a loop 
########################

# Create index_1 to index_3 as a (future variable) - do not assign yet
l_selected <- as.list(1:length(indices))
l_str <- list("Index")
s_var <- as.list(paste(l_str,l_selected,sep=""))

