% This function will perform the theoretical analysis of the tournament
function [POP, BST, FIT] = TourTheFit(B, Strategies, POP0, T, J)
    % Define the number of strategies
    S = length(Strategies);

    % Initialize storage space
    % A row for each strategy, a column for each generation
    POP = zeros(S, J+1); % +1 to account for POP0 too
    FIT = zeros(S, J);
    BST = cell(1, J); % Define as cell array to hold strategy names

    % Define the V matrix, SxS where Vij is the expected payoff V(i|j)
    %
    % NOTICE !
    % THE THEORETICAL V MATRIX WAS DERIVED USING B = [3, 0; 5, 1]
    % AS IN THE PAPER BY MATHIEU, BEAUFILS & DELAHAYE
    % IN CASE OF DIFFERENT B, A SIMULATION WILL BE PERFORMED TO DETERMINE V
    %
    %

    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    %                                                                   %
    %    ! CAUTION - IF ANY CHANGES ARE MADE TO THE EXCEL MATRIX THE    %
    %   READMATRIX LINE SHOULD BE ADJUSTED TOO. STRATEGIES DEFINED ON   %
    %          THE MAIN.M FILE MUST HAVE THE SAME SEQUENCE              %
    %             AS THE HEADER LINE ON THE EXCEL MATRIX !              %
    %                                                                   %
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    
    if B == [3, 0; 5, 1];
        V = readmatrix('V_matrix.xlsx', 'Sheet', 1, 'Range', 'B2:J10');
    else 
        V = ComputePayoffMatrix(Strategies, B, 1000);
    end

    % V matrix was calculated for 1000 rounds. Adjust for T rounds
    V = V * T / 1000;

    % Set initial population
    POP(:, 1) = POP0(:); % column vector

    % For each generation
    for gen = 1:J
        % Current population synthesis
        W = POP(:, gen);
        % Total population
        P = sum(W);
        % Score of each strategy
        g = zeros(S, 1);
        total_points = 0;
        for player = 1:S
            if W(player) == 0
                continue;
            end
            for opponent = 1:S
                if W(opponent) == 0
                    continue;
                end
                % g(i) = sum(W(i)V(i|j)) for every player j
                g(player) = g(player) + W(player) * V(player, opponent);
            end
            
            % Subtract the score he got from playing himself V(i|i)
            g(player) = g(player) - V(player, player);
        end
        % Total points = sum( W(i)*g(i) ) for every player i
        total_points = sum(W .* g);
        % Fitness is defined as the points collected by each strategy
        FIT(:, gen) = g;
        [~, best_strat_indx] = max(g);
        BST{gen} = Strategies{best_strat_indx};
        
        % Population re-distribution W(n+1)(i)=P*Wn(i)g(i)/total_points
        POP(:, gen+1) = P * (W .* g) / total_points;
        % Make negative values from representation errors equal to zero
        POP(POP < 0) = 0;
    end
end