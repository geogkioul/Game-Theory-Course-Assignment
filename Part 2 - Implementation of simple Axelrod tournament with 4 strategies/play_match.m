% The function that will simulate a match between two players
function [score1, score2] = play_match(player1, player2, B, T)
    % Initialize scores
    score1 = 0; score2 = 0;
    % Initialize grim triggers
    grim1 = false; grim2 = false;

    % Initialize last moves array
    % lastMove(1) shows last move of Player 1 and vice versa
    lastMove = [' '; ' '];

    % Play T rounds
    for round = 1:T
        % Determine the moves for each player
        move1 = get_strategy_move(player1, lastMove(2), grim1);
        move2 = get_strategy_move(player2, lastMove(1), grim2);

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

        % Update last moves array
        lastMove(1) = move1;
        lastMove(2) = move2;

        % If opponents last move was 'D' enable grim trigger
        if move1 == 'D'
            grim2 = true;
        elseif move2 == 'D'
            grim1 = true;
        end
    end
end