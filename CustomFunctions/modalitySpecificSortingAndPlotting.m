 %Modality specific trials

 function   modalitySpecificSortingAndPlotting (dataset,dfbf, timeLockedCells, light_trials,sound_trials, window, trialPhase,figureDetails)
                                                           
                                                                
     dfbf_light=dfbf(:,[light_trials],:);
     dfbf_sound=dfbf(:,[sound_trials],:);
     dfbf_timeLockedCells_soundTrials = dfbf(timeLockedCells,[sound_trials],:);
     dfbf_timeLockedCells_lightTrials = dfbf(timeLockedCells,[light_trials],:);
     [sortedCells_light, peakIndices_light] = sortData(dfbf_timeLockedCells_lightTrials(:,:,window), 1);
     [sortedCells_sound, peakIndices_sound] = sortData(dfbf_timeLockedCells_soundTrials(:,:,window), 1);

     dfbf_sorted_timeCells_light = dfbf_timeLockedCells_lightTrials(sortedCells_light,:,:);
     dfbf_sorted_timeCells_sound = dfbf_timeLockedCells_soundTrials(sortedCells_sound,:,:);

     dfbf_timeCells_light_sortedLikeSound = dfbf_timeLockedCells_lightTrials(sortedCells_sound,:,:);
     dfbf_timeCells_sound_sortedLikeLight = dfbf_timeLockedCells_soundTrials(sortedCells_light,:,:);
    
     
     
  %% Plotting dfbf of cells; trial separated according to stimuli and sorted.   
  
  %Normalized to max
             fig5 = figure(7);
            set(fig5,'Position', [700, 700, 1200, 500]);
            subFig1 = subplot(1,2,1);
            %plot light trials- sorted data
            plotSequences(dataset, dfbf_sorted_timeCells_light(:,:,window), trialPhase, 'Frames', 'Light trials-sorted Cells', figureDetails, 1)
            subFig2 = subplot(1,2,2);
            %plot sound trials- sorted according to light trials
            plotSequences(dataset, dfbf_timeCells_sound_sortedLikeLight(:,:,window), trialPhase, 'Frames', 'Sound trials- Sorted like light', figureDetails, 1)
            print(['/home/soumya/suite2P_results/figs/sort/timeCells_mixedTrials_sorted_/' ...
                dataset.mouse_name '_' num2str(dataset.sessionType) '_' num2str(dataset.session) 'light_sorting'],...
                '-djpeg');
    
             fig5 = figure(8);
            set(fig5,'Position', [700, 700, 1200, 500]);
            subFig1 = subplot(1,2,1);
            %plot light trials- sorted data
            plotSequences(dataset, dfbf_sorted_timeCells_sound(:,:,window), trialPhase, 'Frames', 'Sound trials-sorted Cells', figureDetails, 1)
            subFig2 = subplot(1,2,2);
            %plot sound trials- sorted according to light trials
            plotSequences(dataset, dfbf_timeCells_light_sortedLikeSound(:,:,window), trialPhase, 'Frames', 'light trials- Sorted like sound', figureDetails, 1)
            print(['/home/soumya/suite2P_results/figs/sort/timeCells_mixedTrials_sorted_/' ...
                dataset.mouse_name '_' num2str(dataset.sessionType) '_' num2str(dataset.session) 'sound_sorting' ],...
                '-djpeg');
    
            
     %Not normalized to max
     
     
         fig5 = figure(9);
            set(fig5,'Position', [700, 700, 1200, 500]);
            subFig1 = subplot(1,2,1);
            %plot light trials- sorted data
            plotSequences(dataset, dfbf_sorted_timeCells_light(:,:,window), trialPhase, 'Frames', 'Light trials-sorted Cells', figureDetails, 0)
            subFig2 = subplot(1,2,2);
            %plot sound trials- sorted according to light trials
            plotSequences(dataset, dfbf_timeCells_sound_sortedLikeLight(:,:,window), trialPhase, 'Frames', 'Sound trials- Sorted like light', figureDetails, 0)
            print(['/home/soumya/suite2P_results/figs/sort/timeCells_mixedTrials_sorted_/' ...
                dataset.mouse_name '_' num2str(dataset.sessionType) '_' num2str(dataset.session) 'light_sorting_nonNorm'],...
                '-djpeg');
    
             fig5 = figure(10);
            set(fig5,'Position', [700, 700, 1200, 500]);
            subFig1 = subplot(1,2,1);
            %plot light trials- sorted data
            plotSequences(dataset, dfbf_sorted_timeCells_sound(:,:,window), trialPhase, 'Frames', 'Sound trials-sorted Cells', figureDetails, 0)
            subFig2 = subplot(1,2,2);
            %plot sound trials- sorted according to light trials
            plotSequences(dataset, dfbf_timeCells_light_sortedLikeSound(:,:,window), trialPhase, 'Frames', 'light trials- Sorted like sound', figureDetails, 0)
            print(['/home/soumya/suite2P_results/figs/sort/timeCells_mixedTrials_sorted_/' ...
                dataset.mouse_name '_' num2str(dataset.sessionType) '_' num2str(dataset.session) 'sound_sorting_nonNorm' ],...
                '-djpeg');