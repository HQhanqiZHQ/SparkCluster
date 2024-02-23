require(Matrix)
require(RSpectra)

# compute 10 PCs of the Jaccard matrix and save them as a matrix (one principal component vector per column) into a file
computePCs <- function(fname="covid.Rdata",npca=10) {
    # Load the data
    load(fname)
    # Convert 'outcome' to binary format
    outcome_binary <- as.numeric(outcome == "deceased")
    # Compute the GRM
    grm <- grm(dat)
    # Perform PCA on the GRM
    pca_result <- prcomp(grm)
    # Extract the first 10 principal components
    pcs <- pca_result$x[, 1:npca]
    # Save the principal components
    save(pcs, file = "pcs.Rdata")
}

# linear regression of deceased outcome vector on each locus together with age, sex, and 10 PCs
scan <- function(fname = "covid.Rdata", pcs_file = "pcs.Rdata", start, end) {
    load(fname)
    load(pcs_file)
    binary_outcome <- as.numeric(outcome == "deceased")
    p_values <- rep(NA, length(start:end))
    for (i in start:end) {
        locus <- dat[, i]
        temp <- glm(binary_outcome ~ locus + age + sex + pcs[, 1] + pcs[, 2] + pcs[, 3] + pcs[, 4] + pcs[, 5] + pcs[, 6] +
            pcs[, 7] + pcs[, 8] + pcs[, 9] + pcs[, 10], family = binomial(link = "logit"))
        p_values[i] <- summary(temp)$coefficients[2, 4]
    }
    return(p_values)
}

# computation on the cluster: compute window w out of n windows
cluster <- function(id, n, fname = "covid.Rdata", pcs_file = "pcs.Rdata") {
    load(fname)
    load(pcs_file)
    s <- round(seq(1, ncol(dat) + 1, length.out = n + 1))
    p_values <- scan(fname = "covid.Rdata", pcs_file = "pcs.Rdata", start = s[id], end = s[id + 1] - 1)
    return(p_values)
}