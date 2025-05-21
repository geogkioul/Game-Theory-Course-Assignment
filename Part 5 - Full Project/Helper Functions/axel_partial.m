% Main tournament function
function scores = axel_partial(B, Strategies, Pop, T)
% This function makes a PARTIAL simulation of an Axelrod tournament.
% That is, the matches are not simulated to find the payoffs since these
% are deterministic, so we get the match payoff from a precomputed matrix V

% B: 2x2 payoff matrix for the row player
% Strategies: Cell array of strategy names
% Pop: Vector with the number of players for each strategy
% T: Number of rounds in each match
% Scores: Vector of total points collected by each player

    % Calculate the total number of players by adding up the players of each strategy
    N = sum(Pop);
    % Initialize the scores vector
    scores = zeros(1, N);

    % Initialize an empty array for the players (the corresponding
    % index in the Strategies Array)
    players = [];
    for i = 1:length(Strategies) % For each strategy
        % Create Pop(i) number of players with the strategy index
        players = [players; repmat(i, Pop(i), 1)];
    end
    % Get the predetermined payoffs for each possible match
    V = ComputePayoffMatrix(Strategies, B, T);

    % Make the players have all possible matches and store the scores
    for i = 1:N-1
        for j = i+1:N            
            % Update the scores for each player
            scores(i) = scores(i) + V(players(i),players(j));
            scores(j) = scores(j) + V(players(j),players(i));
        end
    end
end