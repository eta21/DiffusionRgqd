// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-


#include "RcppArmadillo.h"

// [[Rcpp::depends(RcppArmadillo)]]


// [[Rcpp::export]]
arma::mat junkfunction() {
    arma::mat m1 = arma::eye<arma::mat>(3, 3);
    arma::mat m2 = arma::eye<arma::mat>(3, 3);
	                     
    return (m1 + m2);
}

