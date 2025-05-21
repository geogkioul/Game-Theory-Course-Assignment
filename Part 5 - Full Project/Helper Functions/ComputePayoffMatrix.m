function V = ComputePayoffMatrix(Strategies, B, T)
    % This function will evaluate the SxS matrix (S: length(Strategies))
    % of V(i|j) values (payoff of i when he meets j)

    S = length(Strategies);
    % Initialize V matrix
    V = zeros(S, S);
    for i = 1:S
        % We can compute only the upper triangular matrix since play_match
        % returns both players' scores
        for j = i:S
            [V(i,j), V(j,i)] = play_match(Strategies{i}, Strategies{j}, B, T);
        end
    end
end
