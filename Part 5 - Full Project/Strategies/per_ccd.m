function move = per_ccd(history, ~)
    % Play 'C', 'C, 'D' periodically
    if mod(size(history, 1), 3) < 2
        move = 'C';
    else
        move = 'D';
    end
end