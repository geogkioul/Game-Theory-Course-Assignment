function move = joss(history, column)
    % Cooperate 90% of the time after a cooperation by the opponent 
    % Always defect after a defection by the opponent
    n = rand();    % random number in [0, 1]

    if isempty(history)
        % Play 'C' when no moves have been played
        move = 'C';
        return;
    end
    op_last_move = history(end, column);
    if op_last_move == 'D'
        % If the oppenent's last move is D , play D
        move = 'D';
    else
        % Play 'C' with 90% chance, after the opponent played C
        if n < 0.9
            move = 'C';
        else
            move = 'D';
        end
    end
end 
