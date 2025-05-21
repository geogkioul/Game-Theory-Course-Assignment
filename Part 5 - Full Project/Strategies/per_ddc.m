function move = per_ddc(history, ~)
    % Play 'D', 'D', 'C' periodically
    if mod(size(history, 1), 3) < 2
        move = 'D';
    else
        move = 'C';
    end
end