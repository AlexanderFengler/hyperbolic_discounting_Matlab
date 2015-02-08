% Title: Solve for optimal parameters in hyperbolic discounting function
% (including simulated choices)
% Author: Alexander Fengler
% Date: February 7th 2015


% Provided a certain k for simulating choices, this function return the k
% that minimizes errors for subjects that have preferences according to a
% logit destribution with unit variance

function [x,y] = findK(k)
%%%%%%%%%%%%%%%%%%%%%%%%%
% READING IN DATA %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize Questionnaire Data
% Four columns:
% 1. Order 
% 2. SIR (small immediate reward) 
% 3. LDR (large delayed reward) 
% 4. Delay
qdat = readtable('kirby.csv');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIMULATING CHOICES FOR GIVEN K     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate / Simulate a vector of decisions for given choice set
% Simplest version:
% Solve Y / (1+k*time) - X >= 0 ? if bigger 0 than choose delayed
% otherwise immediate

% len is the length of the choice vector (number of choices to be
% predicted)
len = length(qdat.LDR);

% We define a new column in qdat that provides the simulated choices 
% 0 represents the immediate reward
% 1 represents the delayed reward
qdat.Choices = zeros(len,1);
for i = 1:len
   qdat.Choices(i) = SimulateChoice(k,qdat.SIR(i),qdat.LDR(i),qdat.Delay(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     DEFINE OBJECTIVE FUNCTION         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sumloglik = GenerateLogLik(cur_k)
    % Define vector that will store the probability that the model chooses
    % as the participant for every choice
   choiceprobabilities = zeros(length(qdat.Choices),1);
   
   for j = 1:len
       % load the choice probability vector for every choice
    choiceprobabilities(j) = GetPChoice(cur_k,qdat.SIR(j),qdat.LDR(j),qdat.Delay(j),qdat.Choices(j));
   end
   
   % take sum of logs and negative to be able to work within minimization
   % framework
   sumloglik = (-1)*(sum(log(choiceprobabilities)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RECOVER K WHEN HAVING SET OF CHOICES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run minimization to find k-value
[x, y] = fminbnd(@GenerateLogLik,0,1);
end


