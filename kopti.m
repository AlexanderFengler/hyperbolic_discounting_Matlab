
function [x,y] = findK
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
% SIMULATING CHOICES WHEN HAVING A K %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Generate / Simulate a vector of decisions for given choice set
% Simplest version:
% 1. define k
% 2. solve Y / (1+alpha*time) - X >= 0 ? if bigger 0 than choose delayed
%    otherwise immediate

% The SimulateChoice function we use here is defined in SimulateChoice.m

% Now we simulate choices for an arbitrary alpha

len = length(qdat.LDR);
alpha = 0.005;
% we define a new column in qdat that provides the simulated choices 
% 0 represents the immediate reward
% 1 represents the delayed reward
qdat.Choices = zeros(len,1);


for i = 1:len
   qdat.Choices(i) = SimulateChoice(alpha,qdat.SIR(i),qdat.LDR(i),qdat.Delay(i));
end



function sumloglik = GenerateLogLik(cur_alpha)
   choiceprobabilities = zeros(length(qdat.Choices),1);
   
   for j = 1:len
    choiceprobabilities(j) = GetPChoice(cur_alpha,qdat.SIR(j),qdat.LDR(j),qdat.Delay(j),qdat.Choices(j));
   end
   
   sumloglik = (-1)*(sum(log(choiceprobabilities)));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RECOVER K WHEN HAVING SET OF CHOICES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Run minimization to find k-value
[x, y] = fminbnd(@GenerateLogLik,0,1);
end


