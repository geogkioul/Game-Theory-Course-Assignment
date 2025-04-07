function move = usually_c(history, column)
    % Play 'C' until the opponent plays a 'C' following by a 'D' 
    if size(history, 1) < 2
        % For the first 2 rounds play 'C'
        move =  'C';
    else
        % If the last move of the opponent was 'C' and the second to last was 'D'
        % play 'D', otherwise play 'C'
        
        last_move = history(end, column);
        before_last_move = history(end-1, column);
    
        if before_last_move == 'C' && last_move == 'D'
            move = 'D';
        else 
            move = 'C';
        end
    end
end 