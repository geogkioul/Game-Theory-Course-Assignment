% Main script from which the Tournament functions are called
% You can tune the B, POP0, T and J parameters below
% Add the Strategies subfolder to the path
addpath("Strategies");
clc;
% Define the payoff matrix for the row player
B = [3, 0; 5, 1];
% Define the strategies matrix - This needs to stay constant
Strategies = {'All-D', 'All-C', 'Grim', 'TitForTat'};
% Define the population matrix
POP0 = [10, 10, 5, 15]; % Example pop0 matrix
% Define the rounds of each match
T = 50;
% Define the number of generations
J = 50;

% Begin the Axelrod tournaments
[POP, BST, FIT] = TourTheFit(B, Strategies, POP0, T, J);
disp("Theoretical Analysis");
disp(POP); disp(BST); disp(FIT);

[POP, BST, FIT] = TourSimFit(B, Strategies, POP0, T, J);
disp("Tournament Simulation");
disp(POP); disp(BST); disp(FIT);