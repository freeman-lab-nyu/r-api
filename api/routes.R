# Libs
library(plumber)
library(jsonlite)
library(mousetrap)

# example
#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#* @get /test
function(){
	list(paste0("hello world"))
}

#* Plot a histogram
#* @png
#* @get /plot
function(){
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b){
  as.numeric(a) + as.numeric(b)
}

# use mousetrap library to get max dev
#* @param a path to .mt file containing mt data to analyze
#* @post /maxdev
function(a){
	# Read a single raw data file from MouseTracker
	mt_data_raw <- read_mt(a, columns = "all", add_trialid = TRUE, add_filename = FALSE)

	# Import the data into mousetrap
	mt_data <- mt_import_wide(mt_data_raw)
	mt_data <- mt_remap_symmetric(mt_data)
	mt_data <- mt_align_start(mt_data)

	mt_imported <- mt_time_normalize(mt_data)
	#mt_imported <- mt_measures(mt_data)

	# Aggregate time-normalized trajectories per condition
	average_trajectories <-  mt_aggregate(mt_imported,
	                                      use="tn_trajectories",
	                                      use2_variables="condition"
	)

	# Calculate mouse-tracking measures
	mt_imported2 <- mt_measures(mt_imported)
	#View(mt_imported2)

	#Get highest maximum deviation, and auc and rt
	ind <- which.max(mt_imported2[["measures"]][["MAD"]])
	mad <- mt_imported2[["measures"]][["MAD"]][ind]
	auc <- mt_imported2[["measures"]][["AUC"]][ind]
	rt <- mt_imported2[["measures"]][["RT"]][ind]
	#View(mad)
	list(paste0("mad: ", mad, " auc: ", auc, " rt: ", rt))
}

