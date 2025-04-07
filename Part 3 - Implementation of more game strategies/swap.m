function move = swap(history, column)
    % Next move is the opposite of the last move
     if isempty(history)
         move = 'C';
     else
         % Play the opposite of the last move 
         last = history(end, 1);
         if last == 'C'
             move = 'D';
         else 
             move = 'C';
         end
      end
end