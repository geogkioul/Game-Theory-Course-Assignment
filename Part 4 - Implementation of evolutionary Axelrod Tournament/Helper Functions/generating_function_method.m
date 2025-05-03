function num_of_ways = generating_function_method(n, k)
    % This function uses the Generating functions method to calculate the
    % number of valid combinations by expanding the function and finding
    % the coefficient of t^k
    syms t;
    
    G = 1;
    for i = 1:length(n)
        G = G * (1 - t^(n(i)+1)) / (1 - t); % Build the generating function
    end
    G_expanded = expand(simplify(expand(G)));
    coeff = flip(coeffs(G_expanded, t, 'All'));
    num_of_ways = coeff(k + 1);
end