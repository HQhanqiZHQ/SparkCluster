combinePValues <- function(num_files) {
    combined_p_values <- numeric()
    for (i in 1:num_files) {
        file_name <- paste("output_", i, ".Rdata", sep = "")
        load(file_name)
        combined_p_values <- c(combined_p_values, p_values)
    }
    return(combined_p_values)
}

applyBonferroniCorrection <- function(p_values, uncorrected_threshold = 0.01) {
    corrected_threshold <- uncorrected_threshold / length(p_values)
    significant_loci <- which(p_values < corrected_threshold)
    return(list(significant_loci = significant_loci, corrected_threshold = corrected_threshold))
}
