function move = per_ccccd(history, ~)
    % Play 4 'C's and then 'D' periodically
    if mod(length(history), 5) < 4
        move = 'C';
    else
        move = 'D';
    end
end