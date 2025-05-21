function p = hypergeometric_pmf(counts, population)
    % This function computes the multivariate hypergeometric PMF
    % counts: how many selected from each strategy
    % population: how many available from each strategy
    if any(counts < 0) || any(counts > population) || sum(counts) > sum(population)
        p = 0;
        return;
    end
    numerator = prod(nchoosek_vec(population, counts));
    denominator = nchoosek(sum(population), sum(counts));
    p = numerator / denominator;
end

function vector = nchoosek_vec(n_vec, k_vec)
    % Vector version of nchoosek
    vector = arrayfun(@(n, k) nchoosek(n, k), n_vec, k_vec);
end