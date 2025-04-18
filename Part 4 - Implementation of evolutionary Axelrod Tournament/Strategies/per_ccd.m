function move = per_ccd(history, ~)
    % Play 'C', 'C, 'D' periodically
    if mod(length(history), 3) < 2
        move = 'C';
    else
        move = 'D';
    end
end