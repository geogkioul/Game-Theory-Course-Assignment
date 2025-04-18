% The function that will simulate a match between two players
function [score1, score2] = play_match(player1, player2, B, T)
    % Initialize scores
    score1 = 0; score2 = 0;
    % Initialize the move history array
    history = [];
    % Define the player ids
    % This will help the players know what column of the history array
    % has their opponent's moves
    player1_id = 1; player2_id = 2;
    % Each player will check the opponent's column by their player id

    % Play T rounds
    for round = 1:T
        % Determine the moves for each player

        % For player 1
        move1 = get_strategy_move(player1, history, player1_id);
        % For player 2
        move2 = get_strategy_move(player2, history, player2_id); 

        % Update scores based on the payoff matrix B
        % The payoff matrix of col player is the transpose of B
        if move1 == 'C' && move2 == 'C'
            score1 = score1 + B(1, 1);
            score2 = score2 + B(1, 1);
        elseif move1 == 'C' && move2 == 'D'
            score1 = score1 + B(1, 2);
            score2 = score2 + B(2, 1);
        elseif move1 == 'D' && move2 == 'C'
            score1 = score1 + B(2, 1);
            score2 = score2 + B(1, 2);
        elseif move1 == 'D' && move2 == 'D'
            score1 = score1 + B(2, 2);
            score2 = score2 + B(2, 2);
        end

        % Update the history array
        history = [history; move1, move2];
    end
end