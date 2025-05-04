% Main script from which the Tournament functions are called



% *** THERE IS A DIFFERENT SECTION FOR EACH OF THE FOUR FUNCTIONS ***


% You can tune the B, POP0, T and J parameters below
% Add the current folder and all its subfolders to the MATLAB path
addpath(genpath(pwd));
clc;
% Define the payoff matrix for the row player
B = [3, 0; 5, 1];
% Define the strategies matrix - This needs to stay constant
Strategies = {'All-C', 'All-D', 'TitForTat', '(CD)*', '(DDC)*', '(CCD)*', '(CCCCD)*', 'Soft-Majo', 'Prober'};
% Define the population matrix
%       AllC  AllD  TFT  CD*  DDC*    CCD* CCCCD*  SM   PROB
POP0 = [0   ,   0,    0,  0,  200,    300,    0,  100,    800]; % Example pop0 matrix
% Define the rounds of each match
T = 1000;
% Define the number of generations
J = 200;
% Define the K parameter for imitation dynamics
K = 3;
% Display the strategies
disp("Strategies used:");
active_strategies = Strategies(POP0 ~= 0);
active_strategies_indexes = find(POP0 ~= 0);
disp(active_strategies);
% Begin the Axelrod tournaments
% You can run each section independently

%% TourTheFit
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

%% TourSimFit
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

%% TourSimImi
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

%% TourTheImi

% You can tune the following parameters
POP0 = [0,0,0,0,6,9,0,3,0];
K = 3;

% Display the strategies
disp("Strategies used:");
active_strategies = Strategies(POP0 ~= 0);
active_strategies_indexes = find(POP0 ~= 0);
disp(active_strategies);


N = sum(POP0);
M = nnz(POP0);

% Find the markov chain transition probability matrix
P = TourTheImi(B, Strategies, POP0, K, T, J);

% Print Transition Matrix and number of states
states = compositions(N, M);
S = size(states, 1);
% Final cell array for transition matrix (1 extra for state headers)
C = cell(S+1, S+1);         

% Set top-left label
C{1,1} = 'Current\Next';

% Set column headers: "State 1", "State 2", ...
for j = 1:S
    C{1,j+1} = sprintf('State %d', j);
end

% Set row headers and fill matrix
for i = 1:S
    C{i+1,1} = sprintf('State %d', i);
    for j = 1:S
        C{i+1,j+1} = P(i,j);
    end
end

if(isfile('./Additional Files/transition_matrix.xlsx'))
    delete('./Additional Files/transition_matrix.xlsx');
end
writecell(C, './Additional Files/transition_matrix.xlsx');

% Final cell array for states matrix (1 extra for state headers)
ST = cell(S+1, M+1);
% Set top-left label
ST{1,1} = 'State\Strategy';

% Set column headers: "Strategy name"
ST(1, 2:end) = active_strategies;

% Fill rows
for i = 1:S
    ST{i+1, 1} = sprintf("State %d", i);
    for j = 1:M
        ST{i+1, j+1} = states(i, j);
    end
end

if(isfile('./Additional Files/state_matrix.xlsx'))
    delete('./Additional Files/state_matrix.xlsx');
end
writecell(ST, './Additional Files/state_matrix.xlsx');

disp("Both transition probabilities matrix and states matrix were saved as Excel files on ./Additional Files folder");
disp("**NOTE**: The Excel files cannot be overwritten if they are open, close them and run the script again to rewrite.");
fprintf('\n\n');

% If we want to find the expected population after J generations
% First we find the J-step transition matrix
multistep_transition_matrix = P^J;
% Then we find the current state from the given population
initial_state = find(all(bsxfun(@eq, states, POP0(active_strategies_indexes)), 2));
% And finally calculate the population after J steps
final_population = zeros(1, length(active_strategies_indexes));
for j = 1:S
    if multistep_transition_matrix(initial_state, j) == 0
        continue;
    else
        final_population = final_population + multistep_transition_matrix(initial_state, j)*states(j, :);
    end
end
fprintf('After %d generations, the expected population synthesis is the following:\n\n', J);

% Display population
for s = 1:length(active_strategies)
    fprintf('  %-12s : %.3f\n', active_strategies{s}, final_population(s));
end
