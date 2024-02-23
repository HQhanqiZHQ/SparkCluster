source("fuse_correlation.r")

# Set the total number of partitions to match the number of SLURM array jobs
total_partitions <- 10 # Adjust this based on the number of output files generated

# Combine the results from all the files
combined_p_values <- combinePValues(total_partitions)
corrected_results <- applyBonferroniCorrection(combined_p_values)
save(corrected_results, file = "corrected_results.Rdata")
