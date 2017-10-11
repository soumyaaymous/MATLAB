function sortedData = sortData(Data, plotFigures)

%nCells = size(Data,1);
%nTrials = size(Data,2);

% Trial average
Data_Avg = squeeze(mean(Data,2)); %2nd dimension is trials

% Sorting (based on Trial Averaged data)
for cell = 1:size(Data,1)
    [~, peakIndices(cell)] = max(Data_Avg(cell,:));
    clear value
end

sortedData = Data(peakIndices);

if plotFigures == 1
    fig5 = figure(5);
    subFig1 = subplot(1,2,1);
    imagesc(Data_Avg)
    title('CS + Trace + US Window - Trial Averaged')
    colorbar
    colormap(fig5,'jet')
    xlabel('Frames', ...
        'FontSize', fontSize,...
        'FontWeight', 'bold')
    set(gca,'XTick', [1,3,5])
    set(gca,'XTickLabel', {'CS'; 'Trace'; 'US'})
    ylabel('Unsorted Cells', ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
    set(gca,'FontSize', fontSize-2)
    
    subFig2 = subplot(1,2,2);
    imagesc(sortedData)
end
