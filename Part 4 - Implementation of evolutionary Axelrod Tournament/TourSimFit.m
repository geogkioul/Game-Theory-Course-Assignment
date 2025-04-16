% This function will perform the simulation of the tournament
function [POP, BST, FIT] = TourSimFit(B, Strategies, POP0, T, J)
    % Define the number of strategies
    S = length(Strategies);

    % Initialize storage space
    % A row for each strategy, a column for each generation
    POP = zeros(S, J+1); % +1 to account for POP0 too
    FIT = zeros(S, J);
    BST = cell(1, J); % Define as cell array to hold strategy names

    % Set initial population
    POP(:, 1) = POP0(:); % column vector

    % Simulate the tournament for each generation
    for gen = 1:J
        scores = axel(B, Strategies, POP(:, gen), T); % Scores after simul
        total_points = sum(scores);
        % Current population synthesis
        W = POP(:, gen);
        % Total population
        P = sum(W);
       
        % Create a map for players and their strategies
        strategy_of_player = zeros(P,1); % P players are assigned to S strategies
        index = 1;
        for strategy = 1:S
            strategy_players_count = POP(strategy, gen);
            strategy_of_player(index:index+strategy_players_count-1) = strategy;
            index = index + strategy_players_count;
        end 
        % Accumulate the scores achieved by players of specific strategy
        accum_strategy_scores = accumarray(strategy_of_player, scores, [S 1], @sum, 0);
        
        % Fitness is defined as the total points collected by each strategy
        FIT(:, gen) = accum_strategy_scores;
        [~, best_strat_indx] = max(accum_strategy_scores);
        BST{gen} = Strategies{best_strat_indx};

        % Population re-distribution POP(n+1)(i)=P*POP(i)accum(i)/total_points
        POP(:, gen+1) = round(P * accum_strategy_scores / total_points);
    end
end