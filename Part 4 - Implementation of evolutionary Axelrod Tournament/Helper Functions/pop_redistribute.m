function int_pop = pop_redistribute(proportions, total)
    % This function will receive the proportions of representation of
    % strategies in the new generation as calculated by the formula
    % W(n+1)(i)=P*Wn(i)g(i)/total_points and convert them to an integer
    % vector keeping the total population constant

    S = length(proportions);

    % First convert to decimal population
    pop = total .* proportions;

    % Floor to get integers
    int_pop = floor(pop);

    % Get the residuals
    res = pop - int_pop;

    % Number of unassigned individuals due to flooring
    remaining = total - sum(int_pop);

    % Assign the remaining individuals to strategies with largest residuals
    [~, index] = sort(res, 'descend');
    % Increase the length(remaining) strategies with largest res by +1
    int_pop(index(1:remaining)) = int_pop(index(1:remaining)) + 1;
end