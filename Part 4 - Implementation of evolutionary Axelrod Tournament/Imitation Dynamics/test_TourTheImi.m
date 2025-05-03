function P = test_TourTheImi(B, Strategies, POP0, K, T, J)
    N = sum(POP0);
    M = length(Strategies(POP0 ~= 0)); % M: number of active strategies
    
    % Compute the payoff matrix of active strategies
    V_total = ComputePayoffMatrix(Strategies, B, T);
    active_strategies= find(POP0 > 0);  % Keep only the values of active strategies
    V = V_total(active_strategies, active_strategies);

    % STEP 1 - Calculate all possible states
    states = compositions(N, M);
    S = size(states, 1);
    % Initialize transition probabilities matrix with zeros
    P = zeros(S, S);

    % STEP 2 - Find the best/non-best strategies for each state
    for state = 1:S
        current_state_vector = states(state, :); % get the whole row
        % If the current state has only one non-zero population strategy
        % then it is an absorbing state since then can be no imitators to
        % change strategy
        if nnz(current_state_vector) == 1
            P(state, state) = 1;
            continue;
        end

        % Now find the total payoff collected by each strategy in the
        % current state
        % Initialize with zeros
        strategy_payoffs = zeros(M, 1);

        for player = 1:M
            total_strategy_payoff = 0;
            for opponent = 1:M
                % If both strategies have non-zero players
                if (current_state_vector(player) > 0 && current_state_vector(opponent) > 0)
                    % Each player of each strategy plays current_state_vector(opponent) games with the opponent
                    if player == opponent % if playing players from the same strategy
                        matches_played = current_state_vector(player) * (current_state_vector(opponent)-1); % -1 to exclude self
                    else
                        matches_played = current_state_vector(player) * current_state_vector(opponent);
                    end
                    % Update total_strategy_payoff
                    total_strategy_payoff = total_strategy_payoff + V(player, opponent)*matches_played;
                end
            end
            % Save the total payoff gained by this strategy
            strategy_payoffs(player) = total_strategy_payoff;
        end

        % Find the best strategy based on total strategy payoff
        max_payoff = max(strategy_payoffs);
        best_strats = find(strategy_payoffs == max_payoff); % Could be more than one
        non_best_strats = setdiff(1:M, best_strats);
        % If there is no sufficient amount of non-best-strat players reduce
        % number of imitators K to a feasible value
        K_actual = min(K, sum(current_state_vector(non_best_strats)));
        
        % STEP 3 - Calculate the difference between the current state and
        % every candidate new one
        for new_state = 1:S
            new_state_vector = states(new_state, :);
            difference_vector = new_state_vector - current_state_vector;
            % Positive entries are gains (should only be in best strats)
            % Negative entries are losses (should only be in non-best
            % strats)
            
            % Find how many players joined each best strategy
            G = difference_vector(best_strats);
            % Find how many players left a non-best strategy
            L = -difference_vector(non_best_strats);

            % Check if the transition from current to new state is valid
            % The sum of both gains and losses should be K
            % Both gains and losses should only have non-negative entries
            if any(G < 0) || any(L < 0) || sum(G) ~= K_actual || sum(L) ~= K_actual
                P(state, new_state) = 0; % If transition is not valid then assign a 0 prob
                continue;
            end

            % STEP 4 - Calculate the probability of a valid transition

            % Hypergeometric probability of selecting K players from
            % non-best strategies (sampling without replacement)
            p_select = hypergeometric_pmf(L, current_state_vector(non_best_strats));
            
            % Multinomial probability of redistributing K players to best
            % strategies
            p_assign = multinomial_pmf(G, ones(1, length(best_strats)) / length(best_strats));

            % The probability of the transition is 
            % Pr(state -> new_state) =
            % p_select * p_assign
            % We multiply them because the selection of K from non-best is
            % independent from their assignment to best
            P(state, new_state) = p_select * p_assign;
        end
    end
end