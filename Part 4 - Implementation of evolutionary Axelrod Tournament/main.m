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
POP0 = 10*ones(length(Strategies), 1); % Example pop0 matrix
% Define the rounds of each match
T = 50;
% Define the number of generations
J = 50;
% Display the strategies
disp("Strategies used:");
disp(Strategies);
% Begin the Axelrod tournaments
% You can run each section independently
%% TourTheFit
[POP, BST, FIT] = TourTheFit(B, Strategies, POP0, T, J);
disp("Theoretical Analysis");
disp("Population per generation"); disp(POP);
disp("Best strategy per generation"); disp(BST);
disp("Strategies' fitness per generation"); disp(FIT);
disp("--------------------------------------------------");

%% TourSimFit
[POP, BST, FIT] = TourSimFit(B, Strategies, POP0, T, J);
disp("Tournament Simulation");
disp("Population per generation"); disp(POP); 
disp("Best strategy per generation"); disp(BST);
disp("Strategies' fitness per generation"); disp(FIT);
disp("--------------------------------------------------");