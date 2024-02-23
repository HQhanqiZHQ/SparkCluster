args <- commandArgs(TRUE)
index <- as.numeric(args[1])

# Check if the script is run as part of an array job or for post-processing
if (!is.na(index) && index > 0) {
    # This part runs when the script is executed by SLURM with an array job index
    set.seed(index)
    source("pset4_template.r")
    res <- cluster(index)
    save(res, file = paste0("file", index))
} else {
    # This part runs for post-processing after all array jobs are completed
    source("fuse_correlation.r")

    # Assuming you know the number of files or can compute it dynamically
    num_files <- 100 # Replace with the actual number of files
    combined_p_values <- combinePValues(num_files)
    corrected_results <- applyBonferroniCorrection(combined_p_values)
    save(corrected_results, file = "corrected_results.Rdata")
}
