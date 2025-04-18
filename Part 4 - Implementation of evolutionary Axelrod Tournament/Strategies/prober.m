function move = prober(history, column)
    % In the beggining he plays 'D', 'C', 'C'
    if isempty(history)
        move = 'D';
    elseif length(history) < 3
        move = 'C';
    else
        if history(2, column) == 'C' && history(3, column) == 'C' % If opp played 'C' on moves 2 &3
            move = 'D';
        else
            move = history(end, column); % Play as TFT
        end
    end
end