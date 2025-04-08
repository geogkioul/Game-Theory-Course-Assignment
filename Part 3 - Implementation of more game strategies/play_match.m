% The function that will simulate a match between two players
function [score1, score2] = play_match(player1, player2, B, T)
    % Initialize scores
    score1 = 0; score2 = 0;
    % Initialize the move history array
    History = [];
    % Define the player ids
    % This will help the players know what column of the history array
    % has their opponent's moves
    player1_id = 1; player2_id = 2;
    % Each player will check the opponent's column by their player id

    % Play T rounds
    for round = 1:T
        % Determine the moves for each player
        % For player 1
        switch player1
            case 'All-D'
                move1 = all_d(History, player2_id);
            case 'All-C'
                move1 = all_c(History, player2_id);
            case 'Grim'
                move1 = grim(History, player2_id);
            case 'TitForTat'
                move1 = tft(History, player2_id);
            case 'Cycle-CDDC'
                move1 = cycle_cddc(History, player2_id);
            case 'Joss'
                move1 = joss(History, player2_id);
            case 'Random'
                move1 = rand_m(History, player2_id);
            case 'Usually-C'
                move1 = usually_c(History, player2_id);
            case 'Swap'
                % Swap player looks at his own strategy not the opponents
                move1 = swap(History, player1_id);
            case 'Not-forgiving-2'
                move1 = not_forgiving2(History, player2_id);
            otherwise
                error('Uknown strategy');
        end

        % For player 2
        switch player2
            case 'All-D'
                move2 = all_d(History, player1_id);
            case 'All-C'
                move2 = all_c(History, player1_id);
            case 'Grim'
                move2 = grim(History, player1_id);
            case 'TitForTat'
                move2 = tft(History, player1_id);
            case 'Cycle-CDDC'
                move2 = cycle_cddc(History, player1_id);
            case 'Joss'
                move2 = joss(History, player1_id);
            case 'Random'
                move2 = rand_m(History, player1_id);
            case 'Usually-C'
                move2 = usually_c(History, player1_id);
            case 'Swap'
                % Swap player looks at his own strategy not the opponents
                move2 = swap(History, player2_id);
            case 'Not-forgiving-2'
                move2 = not_forgiving2(History, player1_id);
            otherwise
                error('Uknown strategy');    
        end

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
        History = [History; move1, move2];
    end
end