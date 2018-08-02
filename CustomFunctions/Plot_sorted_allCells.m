
function Plot_sorted_allCells (dataset, dfbf, trialDetails, figureDetails, dfbf_2D_sorted_timeCells)

[sortedCells, peakIndices] = sortData(dfbf, 1); %@ important change here. Changed timecell sorting to all cell sorting.
        dfbf_sorted_AllCells = dfbf(sortedCells,:,:);
       % dfbf_2D_sorted_timeCells = dfbf_2D_timeLockedCells(sortedCells,:);
        
        
            % Sorting based Sequences - plotting
            trialPhase = 'CS-Trace-US'; % NOTE: this update to "trialPhase" is only for plots
            clear window %for sanity
            window = findWindow(trialPhase, trialDetails);
            
            fig5 = figure(5);
            set(fig5,'Position', [700, 700, 1200, 500]);
            subFig1 = subplot(1,2,1);
            %plot unsorted data
            plotSequences(dataset, dfbf, trialPhase, 'Frames', 'Unsorted Cells', figureDetails, 1)
            subFig2 = subplot(1,2,2);
            %plot sorted data
            plotSequences(dataset, dfbf_sorted_AllCells, trialPhase, 'Frames', 'Sorted Cells', figureDetails, 1)
            print(['/home/soumya/suite2P_results/figs/sort/AllCells_allTrialsAvg_sorted_/' ...
                dataset.mouse_name '_' num2str(dataset.sessionType) '_' num2str(dataset.session) ],...
                '-djpeg');
            
            fig6 = figure(6);
            clf
            set(fig6,'Position',[300,300,1200,500])
            %plot sorted data
            plotdFbyF(dataset, dfbf_2D_sorted_timeCells, trialDetails, 'Frames', 'Sorted Cells', figureDetails, 0)
            print(['/home/soumya/suite2P_results/figs/calciumActivity/dfbf_allTrials_/' ...
                dataset.mouse_name '_' num2str(dataset.sessionType) '_' num2str(dataset.session) 'AllCells_sorted'],...
                '-djpeg');
        