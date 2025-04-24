function P = TourTheImi(B, Strategies, POP0, K, T, J)

    N = sum(POP0);                       % Number of total players
    M = length(Strategies(POP0 ~=0));    % Number of used Strategies (M=3)
    
    % Compute the payoff matrix of used strategies
    V_total = ComputePayoffMatrix(Strategies, B, T);
    active_strategies= find(POP0 > 0);  % Keep only the values of used strategies
    V = V_total(active_strategies, active_strategies);
    
    disp('Payoff Matrix:')
    disp(V);

    % Calculation of possible states (numbers of players per strategy)
    % state = (x1, x2, x3)
    states = [];
    for i = 0:N
        for j = 0:(N - i)
            k = N - i - j;
            states = [states; i, j, k];     % Matrix of states -> SxM
        end
    end

    disp('States:');
    disp(states);
    
    % Initiallisation
    S = size(states, 1);  % Number of possible states
    P = zeros(S, S);      % Transition Matrix
    f = zeros(M, S);      % Fitness for every strategy and state
    
    % Transition Matrix Calculation
    for s = 1:S
        current_state = states(s, :);    % Current state -> (x1, x2, x3)

        disp('State:');
        disp(current_state);

        g = zeros(M, 1);      % Total points per strategy in every state

        % Fitness Calculation for every strategy
        for player = 1:M
            total_payoff = 0;
            for opponent = 1:M
                if(current_state(player) > 0 && current_state(opponent) > 0)
                    % When both player and oponnent strategy have players
                    if player == opponent
                        interactions = current_state(opponent) - 1;  % exclude self
                    else
                        interactions = current_state(opponent);
                    end
                    total_payoff = total_payoff + V(player, opponent) * interactions;
                end
            end
            g(player) = total_payoff;
        end
        % Set fitness per strategy
        f(:, s) = g / (N-1);    

        % Total points -> sum(f(i).*x(i)), for every strategy i
        total_points = dot(f(:, s), current_state);

        disp('Total points:');
        disp(total_points);
        
        % Find best strategy index
        max_score = max(f(:, s));
        best_strat = find(f(:, s) == max_score);

        disp('Max score:');
        disp(max_score);
        disp('Best strategy:');
        disp(best_strat);
        disp('Fitness for every strategy:');
        disp(f(:, s));
     
        % When opponent strategies have zero players, they can not 
        % increase their players, so we remain at the same state-> prob = 1
        if total_points == 0
            P(s, s) = 1;
            continue;
        end
        
        % Transition Matrix Calculation

        % Find all possible combinations of K players that should be removed
        other_strats = setdiff(1:M, best_strat);
        all_combinations = compositions(K, length(other_strats));

        disp('Possible changes');
        disp(all_combinations);
        
        % For every new state combination
        for c = 1:size(all_combinations, 1)
            % get one change vector eg. for K=2 [0,2]
            change_vec = all_combinations(c, :);    
            valid = true;  
        
            % Check if there are enough players for this change
            for idx = 1:length(other_strats)
                if current_state(other_strats(idx)) < change_vec(idx)   
                    % Invalid state when there are less players than 
                    % the ones that should be removed
                    valid = false;
                    break;
                end
            end
            if ~valid
                % When the change vector is invalid move to the next vector
                continue;
            end
        
            % New state initiallisation
            new_state = current_state;
            % Add the K new players to the best strategy
            new_state(best_strat) = new_state(best_strat) + K;

            % Remove the players from the other strategies
            for idx = 1:length(other_strats)
                new_state(other_strats(idx)) = new_state(other_strats(idx)) - change_vec(idx);
            end
        
            % Find new state index
            [~, next_s] = ismember(new_state, states, 'rows');
        
            % Probabilities Calculation
            prob = 1;
            for idx = 1:length(other_strats)
                str = other_strats(idx);    % index of strategy mapping to the current state
                prob = prob * (current_state(str) / N)^change_vec(idx);
            end
            prob = prob * (f(best_strat, s) / total_points)^K;
        
            % Update Transition Matrix
            P(s, next_s) = P(s, next_s) + prob;
        end
        
        % Ensure the probabilities sum (row sum) = 1
        P(s, s) = 1 - sum(P(s, :));

        disp('Updated transition matrix P:');
        disp(P);
    end
end
