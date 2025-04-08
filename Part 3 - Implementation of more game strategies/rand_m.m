function move = rand_m(~, ~)
    % Play a random move
    n = rand(); % random number in (0, 1)
    
    if n < 0.5  % when n < 0.5 play 'C'
         move = 'C';    
    else
         move = 'D';
    end
end
