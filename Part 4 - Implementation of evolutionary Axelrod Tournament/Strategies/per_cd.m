function move = per_cd(history, ~)
    % Play 'C' and 'D' periodically
    if mod(length(history), 2) == 0
        move = 'C';
    else
        move = 'D';
    end
end