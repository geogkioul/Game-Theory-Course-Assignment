function move = gradual(history, column)

    % Number of elements in the punishment sequence
    persistent seq; 
    
    if isempty(history)
        % Cooperate on the first move 
        seq = 0;
        move = 'C';
        return;
    elseif (seq == 1 || seq == 2)
        % Cooperate on the last two moves of the punishment sequence
        seq = seq - 1;
        move = 'C';
        return;
    elseif seq > 2
        % Defect until only the last two elements of the punishment
        % sequence left (two C's)
        seq = seq - 1;
        move = 'D';
        return;
    elseif history(end, column) == 'D'     % If the opponent defects in last move
        % Set a new punishment sequence when the opponent defects
        % and no other sequence is set
        d_moves = sum(history(:, column) == 'D');
        % The punishment sequence is the sum of defections and 2 
        % cooperations minus the defection played now
        seq = d_moves + 2 - 1;  
        move = 'D';
        return;
    else 
        % Cooperate when there is no punishment sequence 
        % and the opponent cooperates
        move = 'C';
        return;
    end
end