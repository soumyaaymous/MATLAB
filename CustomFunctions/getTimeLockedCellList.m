%Maybe this is silly, but I've decided to write out two separate functions
%to identify time cells (isTimeLockedCell.m), and
%to populate a list of the same (getTimeLockedCellList.m).
function timeLockedCells = getTimeLockedCellList(Data, nShuffles, identificationPrinciple, comparisonPrinciple, threshold, window)

timeLockedCells = []; %preallocation
disp('Checking for time-locked cells ...')
for cell = 1:size(Data,1)
    result = isTimeLockedCell(squeeze(Data(cell, :, :)), nShuffles, identificationPrinciple, comparisonPrinciple, threshold, window); %Data should be 2D (trials vs frames)
    %disp(['comparison: ' num2str(comparison)])
    if result
        timeLockedCells = [timeLockedCells cell];
    end
    if (mod(cell, 10) == 0) && cell ~= size(Data,1)
        disp(['... ' num2str(cell) ' cells checked ...'])
    end
end
disp([num2str(length(timeLockedCells)) ' time-locked cells found!'])
disp('... done!')