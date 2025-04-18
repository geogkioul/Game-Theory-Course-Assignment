function move = gradual(history, column)
    % Cooperate on the first move
    if isempty(history)
        move = 'C';
        return;
    else
        % After the nth opponent's defection, defect n times, coop 2

        % Count opponent's defections
        opp_d_count = sum(history(:, column) == 'D');
        % Build punishment sequence, for every opp's D play n Ds and 2 Cs
        punishment_sequence = [];
        for i = 1:opp_d_count
            punishment_sequence = [punishment_sequence; repmat('D', i, 1) 'C'; 'C'];
        end
    end
end