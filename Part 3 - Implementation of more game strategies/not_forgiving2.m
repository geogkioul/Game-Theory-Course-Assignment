function move = not_forgiving2(history, column)
    % If the opponent defects more than 2 times, then always defect  
    if isempty(history) 
        % If no moves have been made yet play 'C'
        move = 'C';
    else
        total_D = sum(history(:, column) == 'D');   % Sum all oponnent's 'D' moves
        if total_D <= 2
            move = 'C';
        else
            move = 'D';
        end
    end
end  