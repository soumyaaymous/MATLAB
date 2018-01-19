cell = 19;
A = squeeze(dfbf_sorted_timeCells(cell, :, :));

%cellCalcium = A(:, (window(1):window(length(window))));
cellCalcium = A(:, (window(1)-2):window(length(window))+2);

%Early
cellCalcium_early = A(1:20, (window(1)-2):window(length(window))+2);
%Mid
cellCalcium_mid = A(21:40, (window(1)-2):window(length(window))+2);
%Late
cellCalcium_late = A(41:end, (window(1)-2):window(length(window))+2);

figure(8);
clf
%imagesc(A)
disp(['Window: ' num2str(window)]);
disp(['nFrames in Window ' num2str(length(window))])
%imagesc(A(:,window)*100)
imagesc(cellCalcium*100)
colormap('jet')
xlabel('Frames', 'FontSize', 16, 'FontWeight', 'bold')
ylabel('Trials', 'FontSize', 16, 'FontWeight', 'bold')
%set(gca,'XTick', size(cellCalcium,2))
%set(gca,'XTickLabel', ((window(1)-2):window(length(window))+2))
z = colorbar;
ylabel(z,'dF/F (%)', 'FontSize', 16, 'FontWeight', 'bold')
title(['Cell: ' num2str(cell) ' - dF/F (%)'], 'FontSize', 18)
%'FontSize', '16', 'FontWeight', 'bold')
    
fig9 = figure(9);
clf
set(fig9,'Position',[100,100,300,300])
plot((cellCalcium')*100, 'r')
hold on
plot(mean(cellCalcium,1)*100, 'b', 'LineWidth', 3)
xlabel('Frames', ...
    'FontSize', 16, 'FontWeight', 'bold')
ylabel('dF/F (%)', ...
    'FontSize', 16, 'FontWeight', 'bold')
title(['Cell: ' num2str(cell) ' - dF/F (%)'], 'FontSize', 18)
%set(gca,'XTick', size(cellCalcium,2))

fig10 = figure(10);
clf
set(fig10,'Position',[200,200,1200,300])
subplot(1,3,1)
plot((cellCalcium_early')*100, 'r')
hold on
plot(mean(cellCalcium_early,1)*100, 'b', 'LineWidth', 3)
xlabel('Frames', ...
    'FontSize', 16, 'FontWeight', 'bold')
ylabel('dF/F (%)', ...
    'FontSize', 16, 'FontWeight', 'bold')
title(['Cell: ' num2str(cell) ' - dF/F (%) - Early Trials'], 'FontSize', 18)

subplot(1,3,2)
plot((cellCalcium_mid')*100, 'r')
hold on
plot(mean(cellCalcium_mid,1)*100, 'b', 'LineWidth', 3)
xlabel('Frames', ...
    'FontSize', 16, 'FontWeight', 'bold')
ylabel('dF/F (%)', ...
    'FontSize', 16, 'FontWeight', 'bold')
title(['Cell: ' num2str(cell) ' - dF/F (%) - Mid Trials'], 'FontSize', 18)

subplot(1,3,3)
plot((cellCalcium_late')*100, 'r')
hold on
plot(mean(cellCalcium_late,1)*100, 'b', 'LineWidth', 3)
xlabel('Frames', ...
    'FontSize', 16, 'FontWeight', 'bold')
ylabel('dF/F (%)', ...
    'FontSize', 16, 'FontWeight', 'bold')
title(['Cell: ' num2str(cell) ' - dF/F (%) - Late Trials'], 'FontSize', 18)