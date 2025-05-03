% This function will perform the simulation of the tournament
function [POP, BST, FIT] = TourSimFit(B, Strategies, POP0, T, J)
    % Define the number of strategies
    S = length(Strategies);
    h = waitbar(0, 'Simulation is running...');
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
        strategy_of_player = [];
        for s = 1:S
            strategy_of_player = [strategy_of_player; repmat(s, POP(s, gen), 1)];
        end
        
        % Accumulate the scores achieved by players of specific strategy
        accum_strategy_scores = accumarray(strategy_of_player, scores, [S 1], @sum, 0);
        
        % Fitness is defined as the total points collected by each strategy
        FIT(:, gen) = accum_strategy_scores;

        max_score = max(accum_strategy_scores);
        best_strats = accum_strategy_scores == max_score;
        BST{gen} = Strategies{best_strats};
        
        % Population re-distribution POP(n+1)(i)=P*POP(i)accum(i)/total_points
        % Use the pop_redistribute function to ensure total population
        % stays the same and distribution proportions are accurate
        POP(:, gen+1) = pop_redistribute(accum_strategy_scores / total_points, P);
        waitbar(gen/J, h);
    end
    close(h);
end