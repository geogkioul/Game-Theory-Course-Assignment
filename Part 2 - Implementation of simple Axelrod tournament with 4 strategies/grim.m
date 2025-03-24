function move = grim(history, column)
    % Check if the column of the history array with the opponent's moves
    % has any 'D' moves. If so play D, else play C
    if isempty(history)
        % If no moves have been made yet play 'C'
        move = 'C';
    else
        grim_trigger = any(history(:, column) == 'D');
        if grim_trigger
            move = 'D';
        else
            move = 'C';
        end
    end
end