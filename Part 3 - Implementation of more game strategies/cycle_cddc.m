function move = cycle_cddc(history, ~)
    % Play repeatedly the same moves

    cycle = ['C', 'D', 'D' ,'C'];   % The sequence of repeated moves 

    if isempty(history)
        % at the beginning play the first move
        index = 1;
    else
        % We calculate the modulo of the current round with the sequence
        % length, to find the player's next move in the sequence
        round = size(history, 1);
        index = mod(round, 4) + 1;
    end
    move = cycle(index);    % next move
end

