% Main script from which Axel is called
% You can tune the B, Pop and T parameters below

% Define the payoff matrix for the row player
B = [3, 1; 4, 2];
% Define the strategies matrix - This needs to stay constant
Strategies = {'All-D', 'All-C', 'Grim', 'TitForTat'};
% Define the population matrix
Pop = [10, 20, 5, 15]; % Example pop matrix
% Define the rounds of each match
T = 50;

% Begin the Axelrod tournament
Scores = axel(B, Strategies, Pop, T);
disp('Final Scores');
disp(Scores);


% ----------------------------------------------------- %
%          Display the scores with a bar graph          %
% ----------------------------------------------------- %

% Define colors for each strategy
strategyColors = containers.Map( ...
    {'All-D', 'All-C', 'Grim', 'TitForTat'}, ... % Keys (Strategies)
    {[0.85 0.33 0.10], [0.00 0.45 0.74], [0.47 0.67 0.19], [0.93 0.69 0.13]} ... % Values (Colors)
);

% Assign each player to a strategy based on Pop
playerStrategies = repelem(Strategies, Pop);
% Create the bar graphc
figure;
b = bar(Scores, 'FaceColor', 'flat'); % Enable custom colors

% Apply colors based on strategy groups
for i = 1:length(Scores)
    b.CData(i, :) = strategyColors(playerStrategies{i});
end

% Label the x-axis
xlabel('Players');
ylabel('Total Score');
title('Axelrod Tournament: Player Scores by Strategy');
   
% Create a legend for strategy colors
hold on;
legendHandles = gobjects(1, length(Strategies)); % Store legend handles
for i = 1:length(Strategies)
    legendHandles(i) = patch(NaN, NaN, strategyColors(Strategies{i}), 'EdgeColor', 'none');
end
legend(legendHandles, Strategies, 'Location', 'northeastoutside');
hold off;