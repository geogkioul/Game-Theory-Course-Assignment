function move = per_ddc(history, ~)
    % Play 'D', 'D', 'C' periodically
    if mod(length(history), 3) < 2
        move = 'D';
    else
        move = 'C';
    end
end