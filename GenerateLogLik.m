function sumloglik = GenerateLogLik(alpha)
    
%    loglik = zeros(length(qdat.Choices),1);
   choiceprobabilities = zeros(length(qdat.Choices),1);
   len  = length(qdat.Choices);
   
   for i = 1:len
    choiceprobabilities(i) = GetPChoice(alpha,qdat.SIR(i),qdat.LDR(i),qdat.Delay(i),qdat.Choices(i));
   end
   
   sumloglik = -1*(sum(log(choiceprobabilities)));
end