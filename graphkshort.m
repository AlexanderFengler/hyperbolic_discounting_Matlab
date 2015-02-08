% Title: Graphing optimal solutions for ks by k used for simulating choices
% Author: Alexander Fengler
% Date: February 7th 2015

ks = 0.001:0.001:0.03;
optimk = zeros(length(ks),1);

for k = 1:length(ks)
    optimk(k) = findK(ks(k));
end

plot(ks,optimk)
