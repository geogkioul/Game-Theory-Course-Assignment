% Example 12a: Sensitivity to repartition computation method
% Define the strategies matrix - This needs to stay constant
Strategies = {'All-C', 'All-D', 'TitForTat', '(CD)*', '(DDC)*', '(CCD)*', '(CCCCD)*', 'Soft-Majo', 'Prober', 'Gradual'};
B = [3, 0; 5, 1]; % Payoff matrix
POP0 = [0,0,0,0,1000,450,0,100,0,0]; % Initial population matrix
T = 1000; % Rounds per match
J = 400; % Generations
% Display the strategies
disp("Strategies used:");
active_strategies = Strategies(POP0 ~= 0);
active_strategies_indexes = find(POP0 ~= 0);
disp(active_strategies);

% TourTheFit
[POP, BST, FIT] = TourTheFit(B, Strategies, POP0, T, J);
disp("Fitness Dynamics - Theoretical Analysis");
for gen = 1:J
    fprintf('==================== Generation %d ====================\n', gen);
    
    % Display population
    fprintf('Population:\n');
    for s = 1:length(active_strategies)
        fprintf('  %-12s : %.3f\n', Strategies{active_strategies_indexes(s)}, POP(active_strategies_indexes(s), gen));
    end

    % Best strategies this generation
    fprintf('Best strategy/strategies: %s\n', strjoin(string(BST(gen)), ', '));

    % Display fitness for best strategies
    fprintf('Fitness:\n');
    for s = 1:length(active_strategies)
        fprintf('  %-12s : %.3f\n', Strategies{active_strategies_indexes(s)}, FIT(active_strategies_indexes(s), gen));
    end

    fprintf('\n');
end

% Plot population dynamics
figure;
plot(0:size(POP,2)-1, POP(active_strategies_indexes, :)', 'LineWidth', 2);

xlabel('Generation');
ylabel('Population');
title('Strategy Population Over Time');
subtitle('Fitness Dynamics - Theoretical Analysis');
legend(active_strategies, 'Location', 'bestoutside');
grid on;

colormap lines;
set(gca, 'FontSize', 12);
ylim([0, max(POP(:))*1.1]);

% TourSimFit
[POP, BST, FIT] = TourSimFit(B, Strategies, POP0, T, J);
disp("Fitness Dynamics - Tournament Simulation");
for gen = 1:J
    fprintf('==================== Generation %d ====================\n', gen);
    
    % Display population
    fprintf('Population:\n');
    for s = 1:length(active_strategies)
        fprintf('  %-12s : %.3f\n', Strategies{active_strategies_indexes(s)}, POP(active_strategies_indexes(s), gen));
    end

    % Best strategies this generation
    fprintf('Best strategy/strategies: %s\n', strjoin(string(BST(gen)), ', '));

    % Display fitness for best strategies
    fprintf('Fitness:\n');
    for s = 1:length(active_strategies_indexes)
        fprintf('  %-12s : %.3f\n', Strategies{active_strategies_indexes(s)}, FIT(active_strategies_indexes(s), gen));
    end

    fprintf('\n');   
end

% Plot population dynamics
figure;
plot(0:size(POP,2)-1, POP(active_strategies_indexes, :)', 'LineWidth', 2);

xlabel('Generation');
ylabel('Population');
title('Strategy Population Over Time');
subtitle('Fitness Dynamics - Simulation Analysis')
legend(active_strategies, 'Location', 'bestoutside');
grid on;

colormap lines;
set(gca, 'FontSize', 12);
ylim([0, max(POP(:))*1.1]);