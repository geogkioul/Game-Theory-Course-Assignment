function move = swap(history, column)
    % Next move is the opposite of the last move
     if isempty(history)
         move = 'C';
     else
         last = history(end, column);
         if last == 'C'
             move = 'D';
         else 
             move = 'C';
         end
      end
end