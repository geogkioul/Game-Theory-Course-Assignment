function move = usually_c(history, column)
    % Play 'C' unless the opponent plays a 'C' following a 'D' (D -> C)
    if size(history, 1) <= 2
        % For the first 2 rounds play 'C'
        move =  'C';
    else
        % If the last move of the opponent was 'C' and the second to last was 'D'
        % play 'D', otherwise play 'C'
        
        last_two = history(end-1:end, column);
    
        if last_two(1) == 'D' && last_two(2) == 'C'
            move = 'D';
        else 
            move = 'C';
        end
    end
end 