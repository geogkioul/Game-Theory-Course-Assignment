function [POP, BST] = TourSimImi(B, Strategies, POP0, K, T, J)
    % Define the number of strategies
    S = length(Strategies);
    h = waitbar(0, 'Simulation is running...');

    % Initialize storage space
    % A row for each strategy, a column for each generation
    POP = zeros(S, J+1); % +1 to account for POP0 too
    BST = cell(1, J); % Define as cell array to hold strategy names

    % Set initial population
    POP(:, 1) = POP0(:); % column vector
    
    % Create a map for players and their strategies
    strategy_of_player = [];
    for s = 1:S
        strategy_of_player = [strategy_of_player; repmat(s, POP0(s), 1)];
    end
    % Simulate the tournament for each generation
    for gen = 1:J
        scores = axel(B, Strategies, POP(:, gen), T); % Scores after simul
               
        % Accumulate the scores achieved by players of specific strategy
        accum_strategy_scores = accumarray(strategy_of_player, scores, [S 1], @sum, 0);
        
        % Find the strategy/strategies with the best overall performance
        max_score = max(accum_strategy_scores);
        best_strats = find(accum_strategy_scores == max_score);
        BST{gen} = Strategies{best_strats};

        % Imitation step. Choose K players with non-best strategy and
        % make them use best strategy in the next generation
        candidates = find(~ismember(strategy_of_player, best_strats));
        % If all used the best strategy
        if isempty(candidates)
            new_strategies = strategy_of_player; % No changes
        else 
            K = min(K, length(candidates)); % In case there are less candidates than k
            selected = randsample(candidates, K);

            % Replace selected strategies with randomly chosen best
            new_strategies = strategy_of_player;
            for i = 1:K
                % Change a selected to a random best strategy
                new_strategies(selected(i)) = best_strats(randi(length(best_strats)));
            end
        end

        % Update population synthesis for next generation
        strategy_of_player = new_strategies;
        POP(:, gen+1) = accumarray(new_strategies, 1, [S 1], @sum, 0);
        waitbar(gen/J, h);
    end
    close(h);
end