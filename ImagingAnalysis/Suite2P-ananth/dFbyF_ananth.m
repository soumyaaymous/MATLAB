function [dfbf, baslines, dfbf_allTrials]=
fontSize = 16;
lineWidth = 2;
markerWidth = 7;
transparency = 0.5;

mouseName = db.mouse_name;
date = db.date;
experiment = 1;
plane = 1;
sessionType = db.sessionType;
session = db.session;

%Fluorescence Data
load(['Users/ananth/Desktop/Work/Analysis/Imaging/' ...
    mouseName '/' date '/' num2str(experiment) ...
    '/F_' mouseName '_' date '_plane' num2str(plane) '.mat'])

%Registration Options
load(['Users/ananth/Desktop/Work/Analysis/Imaging/' ...
    mouseName '/' date '/' num2str(experiment) ...
    '/regops_' mouseName '_' date '.mat'])

[nCells, totalFrames] = size(Fcell{1,1});
nTrials = db.nTrials;
nFrames = db.nFrames; %per trial
trialDuration = db.trialDuration; %seconds
frameRate = round((nFrames/trialDuration),1);

%%
baselines = nan(nCells, nTrials);
dfbf = nan(nCells, nTrials, nFrames);
dfbf_allTrials = nan(nCells,nTrials*nFrames);

raw = nan(nCells, nTrials, nFrames);
for cell = 1:nCells
    for trial = 1:nTrials
        count = trial-1;
        
        %First, separate out the trials, to do a proper dF/F
        raw(cell, trial, :) = Fcell{1,1}(cell,((count*nFrames)+1:(count*nFrames)+nFrames));
        
        %* 10 percentile value correction
        baselines(cell,trial) = prctile(squeeze(raw(cell, trial, :)), 10);
        dfbf(cell, trial, :) = ((raw(cell, trial, :) - baselines(cell,trial))/baselines(cell,trial)); % Change in Fluorescence relative to baseline
        
        % All trials
        calbdf_allTrials(cell,(((count*nFrames)+1):(count*nFrames)+nFrames))=dfbf(cell,trial,:);
    end  % calbdf
end

%Calcium activity from all trials
fig4 = figure(4);
clf
set(fig4,'Position',[100,100,1200,600])
%imagesc(log10(calbdf_allTrials*100));
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
elseif sessionType == 2
    title(['All Trials - Calcium Responses | ' ...
        mouseName ' 350ms TEC S' num2str(session) ' | '...
        num2str(frameRate) ' Hz | '...
        num2str(nFrames) ' frames/trial'] , ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
elseif sessionType == 3
    title(['All Trials - Calcium Responses | ' ...
        mouseName ' 500ms TEC S' num2str(session) ' | '...
        num2str(frameRate) ' Hz | '...
        num2str(nFrames) ' frames/trial'] , ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
elseif sessionType == 4
    title(['All Trials - Calcium Responses | ' ...
        mouseName ' CS-only S' num2str(session) ' | '...
        num2str(frameRate) ' Hz | '...
        num2str(nFrames) ' frames/trial'] , ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
elseif sessionType == 5
    title(['All Trials - Calcium Responses | ' ...
        mouseName ' Spontaneous S' num2str(session) ' | '...
        num2str(frameRate) ' Hz | '...
        num2str(nFrames) ' frames/trial'] , ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
else
    title(['All Trials - Calcium Responses | ' ...
        mouseName ' ? S' num2str(session) ' | '...
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