% Title: Simulate choice when provided with two options of reward//delay combinations (Hyperbolic Discounting applied)
% Author: Alexander Fengler
% Date: Feburary 7th 2015

function choice = SimulateChoice(k,sir,ldr,delay)
% Not used for now
%p = exp(ldr/(1 + k*delay)) / (exp(sir) + exp(ldr/(1 + k*delay)));

% By Chabris/Laibson 2008
% If the right hand side is above 0 we choose the LDR (large delayed
% reward) // coded as 1
% IF the left hand is is below  0 we choose the SIR (small immediate
% reward) // coded as 0
 value =  (ldr/(1 + k*delay)) - sir; 
    if (value >= 0)
        choice = 1;
    else
        choice = 0;
    end
end