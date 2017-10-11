function func_dFbyF_ananth(db,Fcell,ops)
% Run master_file.m first.
close all
%%
fontSize = 16;
lineWidth = 2;
markerWidth = 7;
transparency = 0.5;
%%
mouseName = db.mouse_name;
date = db.date;
experiment = db.expts;
plane = db.nplanes;
sessionType = db.sessionType;
session = db.session;

[nCells, totalFrames] = size(Fcell{1,1});
nTrials = 60;
nFrames = 246; %per trial
trialDuration = 17; %seconds
frameRate = round((nFrames/trialDuration),1);

%%
cabase = nan(nCells, nTrials);
calbdf = nan(nCells, nTrials, nFrames);
calbdf_allTrials = nan(nCells,nTrials*nFrames);

cal = nan(nCells, nTrials, nFrames);
for cell = 1:nCells
    for trial = 1:nTrials
        count = trial-1;
        
        %First, separate out the trials, to do a proper dF/F
        cal(cell, trial, :) = Fcell{1,1}(cell,((count*nFrames)+1:(count*nFrames)+nFrames));
        
        %* 10 percentile value correction
        cabase(cell,trial) = prctile(squeeze(cal(cell, trial, :)), 10);
        calbdf(cell, trial, :) = ((cal(cell, trial, :) - cabase(cell,trial))/cabase(cell,trial)); % Change in Fluorescence relative to baseline
        
        % All trials
        calbdf_allTrials(cell,(((count*nFrames)+1):(count*nFrames)+nFrames))=calbdf(cell,trial,:);
    end  % calbdf
end

%Cell detection
fig1 = figure(1);
set(fig1,'Position',[100,100,1200,500])
subFig1 = subplot(1,2,1);
imagesc(ops.mimg)
colormap(subFig1, gray)
title(['Registered Image | '...
    mouseName ' ST' num2str(sessionType) ' S' num2str(session)], ...
    'FontSize', fontSize-2, ...
    'FontWeight', 'bold')
subFig2 = subplot(1,2,2);
uiopen('/Users/ananth/Desktop/figs/segmentation/identifiedCells.fig',1)
%colormap(subFig2, hsv)
title(['Suite2P Identified Cells | '...
    'Diameter ' num2str(ops.diameter) ' | '...
    'Cells ' num2str(nCells) ' | '...
    mouseName ' ST' num2str(sessionType) ' S' num2str(session)], ...
    'FontSize', fontSize-2, ...
    'FontWeight', 'bold')
print(['/Users/ananth/Desktop/figs/segmentation/compare_identifiedCells_' ...
    mouseName '_' num2str(sessionType) '_' num2str(session)],...
    '-djpeg');

%Calcium activity from all trials
fig2 = figure(2);
set(fig2,'Position',[100,100,1200,600])
imagesc(calbdf_allTrials*100);
colorbar
colormap('jet')
z = colorbar;
ylabel(z,'dF/F (%)', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
%if sessionType == 9
if sessionType == 1
    title(['All Trials - Calcium Responses | ' ...
        mouseName ' 250ms TEC S' num2str(session) ' | '...
        num2str(frameRate) ' Hz | '...
        num2str(nFrames) ' frames/trial'] , ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
else
    title(['All Trials - Calcium Responses | ' ...
        mouseName ' 500ms TEC S' num2str(session) ' | '...
        num2str(frameRate) ' Hz | '...
        num2str(nFrames) ' frames/trial'] , ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
end
%set(gca,'XTick', frameRate*(1:2:17)) %NOTE: Starting 5 frames are skipped
%set(gca,'XTickLabel', ({1; 3; 5; 7; 9; 11; 13; 15; 17})) %NOTE: At 14.5 fps
%set(gca,'XTickLabel', ({1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17})) %NOTE: At 14.5 fps
xlabel('Frames', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
%set(gca,'YTick',[10, 20, 30, 40, 50, 60])
%set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
ylabel('Unsorted Cells', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
set(gca,'FontSize', fontSize-2)
print(['/Users/ananth/Desktop/figs/calciumActivity/cal_allTrials_' ...
    mouseName '_' num2str(sessionType) '_' num2str(session)],...
    '-djpeg');

%Session Average
% fig3 = figure(3);
% imagesc(squeeze(mean(calbdf,2))*100);
% colorbar
% colormap('jet')
% z = colorbar;
% ylabel(z,'dF/F (%)', ...
%     'FontSize', fontSize, ...
%     'FontWeight', 'bold')
% %if sessionType == 9
% if sessionType == 1
%     title(['Session Averaged Calcium Response | ' ...
%         mouseName ' 250 ms TEC S' num2str(session)] , ...
%         'FontSize', fontSize, ...
%         'FontWeight', 'bold')
% else
%     title(['Session Averaged Calcium Response | ' ...
%         mouseName ' 500ms TEC S' num2str(session)] , ...
%         'FontSize', fontSize, ...
%         'FontWeight', 'bold')
% end
% set(gca,'XTick', frameRate*(1:2:17)) %NOTE: Starting 5 frames are skipped
% set(gca,'XTickLabel', ({1; 3; 5; 7; 9; 11; 13; 15; 17})) %NOTE: At 14.5 fps
% %set(gca,'XTickLabel', ({1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17})) %NOTE: At 14.5 fps
% xlabel('Time/s', ...
%     'FontSize', fontSize,...
%     'FontWeight', 'bold')
% %set(gca,'YTick',[10, 20, 30, 40, 50, 60])
% %set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
% ylabel('Cells', ...
%     'FontSize', fontSize,...
%     'FontWeight', 'bold')
% set(gca,'FontSize', fontSize-2)
% print(['/Users/ananth/Desktop/figs/calciumActivity/cal_sessionAvg_' ...
%     mouseName '_' num2str(sessionType) '_' num2str(session)],...
%     '-djpeg');