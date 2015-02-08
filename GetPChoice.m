function pchoice = GetPChoice(k,sir,ldr,delay,realchoice)
      % By Chabris/Laibson 2008 (Likelihood function defined)
      % We calculate the likelihood of the data (real choice) which either
      % takes value 0 or value 1 (immediate or delayed reward respectively)
      % via the logit functions on the right hand sight... 
   if realchoice == 1
        pchoice = exp(ldr/(1 + k*delay)) / (exp(sir) + exp(ldr/(1 + k*delay))); 
   else
        pchoice = (1 -  (exp(ldr/(1 + k*delay)) / (exp(sir) + exp(ldr/(1 + k*delay)))));    
   end 
end