function p = multinomial_pmf(counts, probabilities)
    % This function returns the probability mass function of given counts for each strategy for
    % K selected players, given probabilities of each strategy in each
    % player selection.
    % The sum of counts is equal to K
    K = sum(counts);
    numerator = factorial(K);
    denominator = prod(factorial(counts));
    p = numerator / denominator * prod(probabilities .^ counts);
end