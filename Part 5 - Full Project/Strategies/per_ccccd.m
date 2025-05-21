function move = per_ccccd(history, ~)
    % Play 4 'C's and then 'D' periodically
    if mod(size(history, 1), 5) < 4
        move = 'C';
    else
        move = 'D';
    end
end