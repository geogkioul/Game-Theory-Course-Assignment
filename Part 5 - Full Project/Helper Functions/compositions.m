function comps = compositions(n, k)
    % Returns all possible compositions of number n as k non negative numbers 
    if k == 1
        comps = n;
    else
        comps = [];
        for i = 0:n
            sub_comps = compositions(n - i, k - 1);
            comps = [comps; [i * ones(size(sub_comps, 1), 1), sub_comps]];
        end
    end

end