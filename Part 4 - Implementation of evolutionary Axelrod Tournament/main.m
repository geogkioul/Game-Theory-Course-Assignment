% Main script from which the Tournament functions are called
% You can tune the B, POP0, T and J parameters below
% Add the current folder and all its subfolders to the MATLAB path
addpath(genpath(pwd));
clc;
% Define the payoff matrix for the row player
B = [3, 0; 5, 1];
% Define the strategies matrix - This needs to stay constant
Strategies = {'All-C', 'All-D', 'TitForTat', '(CD)*', '(DDC)*', '(CCD)*', '(CCCCD)*', 'Soft-Majo', 'Prober'};
% Define the population matrix
POP0 = [0,0,0,100,100,0,0,100,0]; % Example pop0 matrix
% Define the rounds of each match
T = 100;
% Define the number of generations
J = 90;
% Define the K parameter for imitation dynamics
K = 10;
% Display the strategies
disp("Strategies used:");
disp(Strategies(POP0 ~=0));
% Begin the Axelrod tournaments
% You can run each section independently

%% TourTheFit
[POP, BST, FIT] = TourTheFit(B, Strategies, POP0, T, J);
disp("Fitness Dynamics - Theoretical Analysis");
for gen = 1:J
    fprintf('==================== Generation %d ====================\n', gen);
    
    % Display population
    fprintf('Population:\n');
    for s = 1:length(Strategies)
        fprintf('  %-12s : %.3f\n', Strategies{s}, POP(s, gen));
    end

    % Best strategies this generation
    fprintf('Best strategy/strategies: %s\n', strjoin(string(BST(s)), ', '));

    % Display fitness for best strategies
    fprintf('Fitness:\n');
    for s = 1:length(Strategies)
        fprintf('  %-12s : %.3f\n', Strategies{s}, FIT(s, gen));
    end

    fprintf('\n');
end

% Plot population dynamics
figure;
plot(0:size(POP,2)-1, POP', 'LineWidth', 2);

xlabel('Generation');
ylabel('Population');
title('Strategy Population Over Time');
subtitle('Fitness Dynamics - Theoretical Analysis');
legend(Strategies, 'Location', 'best');
grid on;

colormap lines;
set(gca, 'FontSize', 12);
ylim([0, max(POP(:))*1.1]);

%% TourSimFit
[POP, BST, FIT] = TourSimFit(B, Strategies, POP0, T, J);
disp("Fitness Dynamics - Tournament Simulation");
for gen = 1:J
    fprintf('==================== Generation %d ====================\n', gen);
    
    % Display population
    fprintf('Population:\n');
    for s = 1:length(Strategies)
        fprintf('  %-12s : %.3f\n', Strategies{s}, POP(s, gen));
    end

    % Best strategies this generation
    fprintf('Best strategy/strategies: %s\n', strjoin(string(BST(s)), ', '));

    % Display fitness for best strategies
    fprintf('Fitness:\n');
    for s = 1:length(Strategies)
        fprintf('  %-12s : %.3f\n', Strategies{s}, FIT(s, gen));
    end

    fprintf('\n');

    ComputePayoffMatrix(Strategies(POP0 ~=0), B, T)
    
end

% Plot population dynamics
figure;
plot(0:size(POP,2)-1, POP', 'LineWidth', 2);

xlabel('Generation');
ylabel('Population');
title('Strategy Population Over Time');
subtitle('Fitness Dynamics - Simulation Analysis')
legend(Strategies, 'Location', 'best');
grid on;

colormap lines;
set(gca, 'FontSize', 12);
ylim([0, max(POP(:))*1.1]);

%% TourSimImi
[POP, BST] = TourSimImi(B, Strategies, POP0, K, T, J);
disp("Imitation Dynamics - Tournament Simulation");
for gen = 1:J
    fprintf('==================== Generation %d ====================\n', gen);
    
    % Display population
    fprintf('Population:\n');
    for s = 1:length(Strategies)
        fprintf('  %-12s : %.3f\n', Strategies{s}, POP(s, gen));
    end

    % Best strategies this generation
    fprintf('Best strategy/strategies: %s\n', strjoin(string(BST(s)), ', '));

    fprintf('\n');
end

% Plot population dynamics
figure;
plot(0:size(POP,2)-1, POP', 'LineWidth', 2);

xlabel('Generation');
ylabel('Population');
title('Strategy Population Over Time');
subtitle('Imitation Dynamics - Simulation Analysis')
legend(Strategies, 'Location', 'best');
grid on;

colormap lines;
set(gca, 'FontSize', 12);
ylim([0, max(POP(:))*1.1]);

%% TourTheImi

POP0 = [0,0,0,1,1,0,0,1,0]; % N=sum(POP0)--> here N=3
K = 1;

P = TourTheImi(B, Strategies, POP0, K, T, J);

% Print Transition Matrix
disp('Transition Matrix P:');
disp(P);

