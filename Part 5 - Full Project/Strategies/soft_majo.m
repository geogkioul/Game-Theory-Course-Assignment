function move = soft_majo(history, column)
    % If on first round, play 'C'
    if isempty(history)
        move = 'C';
        return;
    end
    % Play opponents majority move. 'C' in case of equality
    c_count = sum(history(:, column) == 'C');
    d_count = sum(history(:, column) == 'D');
    if d_count > c_count
        move = 'D';
    else
        move = 'C';
    end
end