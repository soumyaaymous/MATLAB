function [RepetitionRate,baselines,cell,trial] = RepetitionRateCalculator (dataset,dfbf)


[sortedCells, peakIndices] = sortData(dfbf, 1); %sortData will take trial averaged matrix before finding max and sorting.
dfbf_sorted_AllCells = dfbf(sortedCells,:,:);

%For each cell, take each trial, establish a baseline, find if it was
%active wrt baseline in it's frame of choice

count= zeros(size(dfbf,1));

for cell= 1:size(dfbf,1)
    
    for trial= 1:size(dfbf,2)
         baselines(cell,trial) = prctile(squeeze(dfbf_sorted_AllCells(cell, trial, :)), 10);
          if dfbf(cell,trial,peakIndices(cell))>=baselines(cell,trial)+2*(std(dfbf_sorted_AllCells(cell,trial,:)));
             count(cell)= count(cell)+1;
             
          end
    end
    
end

RepetitionRate= count*(100/dataset.nTrials);

              

