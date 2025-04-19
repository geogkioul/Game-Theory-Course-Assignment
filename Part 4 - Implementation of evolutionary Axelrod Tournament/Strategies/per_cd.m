function move = per_cd(history, ~)
    % Play 'C' and 'D' periodically
    if mod(size(history, 1), 2) == 0
        move = 'C';
    else
        move = 'D';
    end
end