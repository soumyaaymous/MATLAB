A = dfbf_timeLockedCells;

figure(9)
clf
for trial = 1:size(A,2)
    plot((squeeze(A(7,trial,90:110))'*100)+trial*5, 'black')
    hold on;
end

%hold on
%plot(squeeze(squeeze(mean(A(16,:,:),2)))*100, 'r')
title('All trials for cell')
xlabel('Frames')
ylabel('dF/F (%)')