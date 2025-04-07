function move = rand_m(history, column)
    % Play a random move
    n = rand(); % random number between 0 and 1
    
    if n < 0.5  % when n < 0.5 play 'C'
         move = 'C';    
    else
         move = 'D';
    end
end
