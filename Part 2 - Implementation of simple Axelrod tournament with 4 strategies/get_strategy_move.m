function move = get_strategy_move(strategy, opponentLastMove, grim)
    switch strategy
        case 'All-D'
            move = 'D';
        case 'All-C'
            move = 'C';
        case 'Grim'
            if grim % If the opponent has ever played D before
                move = 'D';
            else
                move = 'C';
            end
        case 'TitForTat'
            if isempty(opponentLastMove) % First round
                move = 'C';
            else
                move = opponentLastMove; % Mimic opponent's last move
            end
        otherwise
            error('Uknown strategy');
    end