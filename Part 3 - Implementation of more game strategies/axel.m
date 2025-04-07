% Main tournament function
function scores = axel(B, Strategies, Pop, T)
% B: 2x2 payoff matrix for the row player
% Strategies: Cell array of strategy names
% Pop: Vector with the number of players for each strategy
% T: Number of rounds in each match
% Scores: Vector of total points collected by each player

    % Calculate the total number of players by adding up the players of each strategy
    N = sum(Pop);
    % Initialize the scores vector
    scores = zeros(1, N);

    % Initialize an empty cell array for the players
    players = {};
    for i = 1:length(Strategies) % For each strategy
        % Create Pop(i) number of players with the strategy name
        players = [players; repmat({Strategies{i}}, Pop(i), 1)];
    end

    % Make the players have all possible matches and store the scores
    for i = 1:N-1
        for j = i+1:N
            % Play the match
            [match_score1, match_score2] = play_match(players{i}, players{j}, B, T);
            % Update the scores for each player
            scores(i) = scores(i) + match_score1;
            scores(j) = scores(j) + match_score2;
        end
    end
end