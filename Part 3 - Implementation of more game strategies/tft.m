function move = tft(history, column)
    % Check if any moves have been played. If not play 'C'
    if isempty(history)
        move = 'C';
    else
    % Play the move that the opponent played in the last round
        move = history(end, column);
    end
end