library(plumber)
r <- plumb("routes.R")  # Where 'plumber.R' is the location of the file shown above
r$run(port=8000)