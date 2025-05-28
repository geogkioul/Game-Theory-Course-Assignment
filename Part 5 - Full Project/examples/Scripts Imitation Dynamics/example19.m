% Example 19 - N = 6, TFT-CD*-DDC*
% Define the strategies matrix - This needs to stay constant
Strategies = {'All-C', 'All-D', 'TitForTat', '(CD)*', '(DDC)*', '(CCD)*', '(CCCCD)*', 'Soft-Majo', 'Prober', 'Gradual'};
B = [3, 0; 5, 1]; % Payoff matrix
POP0 = [0,0,2,2,2,0,0,0,0,0]; % Initial population matrix
T = 1000; % Rounds per match
J = 10; % Generations
K = 1; % Number of imitators/generation

% Display the strategies
disp("Strategies used:");
active_strategies = Strategies(POP0 ~= 0);
active_strategies_indexes = find(POP0 ~= 0);
disp(active_strategies);

% TourSimImi
[POP, BST] = TourSimImi(B, Strategies, POP0, K, T, J);
disp("Imitation Dynamics - Tournament Simulation");
for gen = 1:J
    fprintf('==================== Generation %d ====================\n', gen);
    
    % Display population
    fprintf('Population:\n');
    for s = 1:length(active_strategies)
        fprintf('  %-12s : %.3f\n', Strategies{active_strategies_indexes(s)}, POP(active_strategies_indexes(s), gen));
    end

    % Best strategies this generation
    fprintf('Best strategy/strategies: %s\n', strjoin(string(BST(gen)), ', '));

    fprintf('\n');
end

% Plot population dynamics
figure;
plot(0:size(POP,2)-1, POP(active_strategies_indexes, :)', 'LineWidth', 2);

xlabel('Generation');
ylabel('Population');
title('Strategy Population Over Time');
subtitle('Imitation Dynamics - Simulation Analysis')
legend(active_strategies, 'Location', 'bestoutside');
grid on;

colormap lines;
set(gca, 'FontSize', 12);
ylim([0, max(POP(:))*1.1]);

% TourTheImi


N = sum(POP0);
M = nnz(POP0);

% Find the markov chain transition probability matrix
P = TourTheImi(B, Strategies, POP0, K, T, J);
% Calculate the states
states = compositions(N, M);
S = size(states, 1);

% Color code the different states
% Normalize each row so it sums to 1 (proportions)
row_sums = sum(states, 2);
row_sums(row_sums == 0) = 1;  % avoid division by zero
state_colors = states ./ row_sums;  % each row now sums to 1

% Create the directed graph of state transitions
G = digraph(P);
G = rmedge(G, 1:numnodes(G), 1:numnodes(G));

% Create a figure
figure;
p = plot(G, 'XData', states(:,2), 'YData', states(:,3), 'NodeColor', state_colors, 'MarkerSize', 7);
xlabel(['Population of Strategy: ', active_strategies{2}]);
ylabel(['Population of Strategy: ', active_strategies{3}]);
title('Directed Graph of state transitions');

% Create a separate legend box to show the translation of state numbers (graph nodes)
% to state vectors (populations of active strategies)
% This will appear in a seperate window
state_legend = uifigure('Name', 'State Map', 'Position', [100 100 400 600]);
% Table data
str_labels = strings(S, 1);
for i = 1:S
    vec_str = sprintf('%d ', states(i, :));
    str_labels(i) = sprintf('%2d → [%s]', i, strtrim(vec_str));
end
 % Add title label
strategy_str = strjoin(active_strategies, ', ');
uilabel(state_legend, ...
    'Text', ['Active strategies: ', strategy_str], ...
    'FontWeight', 'bold', ...
    'Position', [20 560 360 30]);

% Create scrollable table
uitable(state_legend, ...
    'Data', str_labels, ...
    'ColumnName', {'State Index (Node) → State Vector (Populations)'}, ...
    'FontName', 'Courier', ...
    'Position', [20 20 360 530]);