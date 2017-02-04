########################
# Function for Leave-One-Out Cross Validation.
# Replace 'DF' and 'l_models'
# Specify models like: my_model <- "gamlss(Data ~ pb(Date,df=2),data=new.df)"
########################

CV_top <- function(nbr,l_model,my_df) {
  dim_cv <- as.list(0:(length(my_df$Data)-1))
  l_model<-list(l_model)
  Estimates<-mapply(CV_bottom,dim_cv,l_model,list(my_df))
  return(mean(Estimates))
}

CV_bottom<-function(counter,cv_model,cv_df) {
  # Set the counter 
  i <- counter
  # Subset without target observation
  new.df <- subset(cv_df,Date !=length(cv_df$Data) - i)
  # Estimate Model
  b1 <-eval(parse(text=cv_model))
  # Get target observation
  specific.df <- subset(cv_df,Date ==length(cv_df$Data) - i)
  # Get yhat & ytrue
  y_hat <- predict(b1,newdata=data.frame(specific.df)[2],type="response",data=new.df) 
  y_true <- specific.df$Data
  # Get Squared Error
  m_value <- (y_true-y_hat)^2
  return(m_value)
}

l_models <- as.list(c(my_model1,my_model2,my_model3,my_model4))
CV<-mapply(CV_top,1,l_models,list(DF))
