

function [sound_trials, light_trials] = sortTrialsByModality (dataset)

light_trials=[];
sound_trials=[];

%ntrials=63;
ntrials= dataset.nTrials;
blockLength = 5; %number of trials in each block. Mixed trials have alternating blocks of light and sound stimuli.
n=5;
i=1;


while  (n+2*blockLength) < ntrials
    
    light_trials(i:i+blockLength-1) = (n:n+blockLength -1);
    n=n+blockLength;
    
    sound_trials(i:i+blockLength-1) = (n:n+blockLength -1);
    n=n+blockLength;
    

    
    i=i+blockLength;
end


if n+blockLength < ntrials %&& ntrials < n+2*blockLength
        light_trials(i:i+blockLength-1) = (n:n+blockLength -1);
        n=n+blockLength;
        
        x=ntrials-n; %trials left
       sound_trials(i:i+x) = (n:ntrials);
        
        
  
        else if n < ntrials &&  ntrials < n + blockLength
         x=ntrials-n; %trials left
         light_trials(i:i+x) = (n:ntrials);
         
          
          
            end  
         
end

         
  





