% Requirements - dodFbyF.m
%                getSessionDetails.m
%                findWindow.m
%                plotdFbyF.m
% These may be found in "CustomFunctions"
%tic
%close all
clear
addpath(genpath('/Users/ananth/Documents/MATLAB/CustomFunctions')) % my custom functions
%% SET ALL DEFAULT OPTIONS HERE

% UPDATE Christmas 2016: number of clusters determined automatically, but
% do specify the "diameter" of an average cell for best results. You can do this with either
% db(iexp).diameter, or ops0.diameter

% check out the README file for detailed instructions (and extra options)
addpath('/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth/localCopies') % add the path to your make_db file

% overwrite any of these default options in your make_db file for individual experiments
make_db; % RUN YOUR OWN MAKE_DB SCRIPT TO RUN HERE

ops0.toolbox_path = '/Users/ananth/Documents/MATLAB/ImagingAnalysis/Suite2P-ananth/';
if exist(ops0.toolbox_path, 'dir')
    addpath(genpath(ops0.toolbox_path)) % add local path to the toolbox
else
    error('toolbox_path does not exist, please change toolbox_path');
end

% mex -largeArrayDims SpikeDetection/deconvL0.c (or .cpp) % MAKE SURE YOU COMPILE THIS FIRST FOR DECONVOLUTION
ops0.useGPU                 = 0; % if you can use an Nvidia GPU in matlab this accelerates registration approx 3 times. You only need the Nvidia drivers installed (not CUDA).
ops0.fig                    = 1; % turn off figure generation with 0
% ops0.diameter               = 12; % most important parameter. Set here, or individually per experiment in make_db file

% root paths for files and temporary storage (ideally an SSD drive. my SSD is C:/)
ops0.RootStorage            = '/Users/ananth/Desktop/Work/dataSuite2P/'; % Suite2P assumes a folder structure, check out README file
ops0.temp_tiff              = '/Users/ananth/Desktop/Work/dataSuite2P/temp.tif'; % copies each remote tiff locally first, into this file
ops0.RegFileRoot            = '/Users/ananth/Desktop/Work/Analysis/Imaging/';  % location for binary file
ops0.DeleteBin              = 1; % set to 1 for batch processing on a limited hard drive
ops0.ResultsSavePath        = '/Users/ananth/Desktop/Work/Analysis/Imaging/'; % a folder structure is created inside
ops0.RegFileTiffLocation    = []; %'D:/DATA/'; % leave empty to NOT save registered tiffs (slow)

% registration options
ops0.doRegistration         = 1; % skip (0) if data is already registered
ops0.showTargetRegistration = 0; % shows the image targets for all planes to be registered
ops0.PhaseCorrelation       = 1; % set to 0 for non-whitened cross-correlation
ops0.SubPixel               = Inf; % 2 is alignment by 0.5 pixel, Inf is the exact number from phase correlation
ops0.NimgFirstRegistration  = 500; % number of images to include in the first registration pass
ops0.nimgbegend             = 250; % frames to average at beginning and end of blocks
ops0.dobidi                 = 1; % infer and apply bidirectional phase offset

% cell detection options
ops0.ShowCellMap            = 1; % during optimization, show a figure of the clusters
ops0.sig                    = 0.5;  % spatial smoothing length in pixels; encourages localized clusters
ops0.nSVDforROI             = 1000; % how many SVD components for cell clustering
ops0.NavgFramesSVD          = 1000; % how many (binned) timepoints to do the SVD based on
ops0.signalExtraction       = 'raw'; % how to extract ROI and neuropil signals: 'raw', 'regression'

% spike deconvolution options
ops0.imageRate              = 12;   % imaging rate (cumulative over planes!). Approximate, for initialization of deconvolution kernel.
ops0.sensorTau              = 2; % decay half-life (or timescale). Approximate, for initialization of deconvolution kernel.
ops0.maxNeurop              = 1; % for the neuropil contamination to be less than this (sometimes good, i.e. for interneurons)
ops0.recomputeKernel        = 1; % whether to re-estimate kernel during optimization (default kernel is "reasonable", if you give good timescales)
ops0.sameKernel             = 1; % whether the same kernel should be estimated for all neurons (robust, only set to 0 if SNR is high and recordings are long)

% red channel options
% redratio = red pixels inside / red pixels outside
% redcell = redratio > mean(redratio) + redthres*std(redratio)
% notred = redratio < mean(redratio) + redmax*std(redratio)
ops0.redthres               = 1.5; % the higher the thres the less red cells
ops0.redmax                 = 1; % the higher the max the more NON-red cells
%keyboard
%% RUN THE PIPELINE HERE
db0 = db;
for iexp = 1:length(db) %[3:length(db) 1:2]
    disp(['Analyzing ' ...
        db(iexp).mouse_name '_' ...
        num2str(db(iexp).sessionType) '_' ...
        num2str(db(iexp).session) ...
        ' - Date: ' db(iexp).date])
    if 0
        run_pipeline(db(iexp), ops0);
        % deconvolved data into (dat.)cl.dcell, and neuropil subtraction coef
        % commented out for now, back up ~ 10 May
        % add_deconvolution(ops0, db0(iexp));
        
        % add red channel information (if it exists)
        if isfield(db0,'expred') && ~isempty(db0(iexp).expred)
            ops0.nchannels_red = db0(iexp).nchannels_red;
            
            run_REDaddon(iexp, db0, ops0) ; % create redcell array
            DetectRedCells; % fills dat.cl.redcell and dat.cl.notred
        end
        %load(sprintf('%s/F_%s_%s_plane%d.mat', ops0.ResultsSavePath, db(iexp).mouse_name, db(iexp).date, db(iexp).nplanes))
        %disp('Suite2P pipeline complete!')
    end
    
    % Manual curation
    %new_main
    
    %Custom Section
    if ops0.fig
        figureDetails.fontSize = 16;
        figureDetails.lineWidth = 2;
        figureDetails.markerSize = 10;
        figureDetails.transparency = 0.5;
    end
    
    %trialDetails = getTrialDetails(db(iexp));
    trialDetails = getTrialDetails(db(iexp));
    
    % dF/F - custom
    %Fluorescence Data
    load(['Users/ananth/Desktop/Work/Analysis/Imaging/' ...
        db(iexp).mouse_name '/' db(iexp).date '/' num2str(db(iexp).expts) ...
        '/F_' db(iexp).mouse_name '_' db(iexp).date '_plane' num2str(db(iexp).nplanes) '.mat'])
    
    %Registration Options
    load(['Users/ananth/Desktop/Work/Analysis/Imaging/' ...
        db(iexp).mouse_name '/' db(iexp).date '/' num2str(db(iexp).expts) ...
        '/regops_' db(iexp).mouse_name '_' db(iexp).date '.mat'])
    
    [dfbf, baselines, dfbf_2D] = dodFbyF(db(iexp), Fcell{1,1});
    
    %Add section to use only significant events
    
    if ops0.fig
        %Calcium activity from all trials
        fig4 = figure(4);
        clf
        set(fig4,'Position',[300,300,1200,500])
        %subFig1 = subplot(2,1,1);
        %plot unsorted data
        plotdFbyF(db(iexp), dfbf_2D, trialDetails, 'Frames', 'Unsorted Cells', figureDetails, 1)
        %subFig2 = subplot(2,1,2);
        %plot sorted data
        %plotdFbyF(db(iexp), dfbf_2D_sorted, trialDetails, 'Frames', 'Sorted Cells', figureDetails, 1)
        print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_allTrials_' ...
            db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
            '-djpeg');
    end
    
    if 1
        % Accept only reliable time cells
        % Tuning and time field fidelity
        trialPhase = 'CS-Trace-US'; % Crucial
        clear window %for sanity
        window = findWindow(trialPhase, trialDetails);
        timeLockedCells = getTimeLockedCellList(dfbf, 5000, 'AOC' ,'Average', 1, window);
        %timeLockedCells = getTimeLockedCellList(dfbf, 5000, 'Peak' ,'Minima', 1, window);
        
        if 1
            %Trial reliability
            [trialReliability, finalTimeCellList] = getTrialReliability(dfbf, window);
            sumTrialReliability = sum(trialReliability,2);
            
            %Only for plotting:
            A = nan(1,size(dfbf,1));
            A(timeLockedCells) = sumTrialReliability(timeLockedCells);
            B = zeros(1,size(dfbf,1));
            B(timeLockedCells) = nan;
            B(~isnan(B)) = sumTrialReliability(~isnan(B));
            
            if ops0.fig
                fig11 = figure(11);
                set(fig11,'Position',[300,300,1200,500])
                plot(sumTrialReliability, 'b', 'LineWidth', figureDetails.lineWidth)
                hold on
                plot(A, 'r*', 'MarkerSize', figureDetails.markerSize)
                hold on
                plot(B, 'go', 'MarkerSize', figureDetails.markerSize)
                title('Time Cell Analysis - Trial Reliability during ISI', ...
                    'FontSize', figureDetails.fontSize, ...
                    'FontWeight', 'bold')
                xlabel('Cells', ...
                    'FontSize', figureDetails.fontSize, ...
                    'FontWeight', 'bold')
                ylabel('Sum of trials with activity', ...
                    'FontSize', figureDetails.fontSize, ...
                    'FontWeight', 'bold')
                set(gca,'FontSize', figureDetails.fontSize-2)
                legend('All Cells', 'Time Cells', 'Not Time Cells')
            end
        end
        
        % Sorting
        %trialPhase = 'CS-Trace-US';
        dfbf_timeLockedCells = dfbf(timeLockedCells,:,:);
        dfbf_2D_timeLockedCells = dfbf_2D(timeLockedCells,:,:);
        
        if isempty(timeLockedCells)
            disp('No time cells found')
        else
            [sortedCells, peakIndices] = sortData(dfbf_timeLockedCells(:,:,window), 1);
            dfbf_sorted_timeCells = dfbf_timeLockedCells(sortedCells,:,:);
            dfbf_2D_sorted_timeCells = dfbf_2D_timeLockedCells(sortedCells,:);
            
            if ops0.fig
                % Sorting based Sequences - plotting
                trialPhase = 'CS-Trace-US'; % NOTE: this update to "trialPhase" is only for plots
                clear window %for sanity
                window = findWindow(trialPhase, trialDetails);
                
                fig5 = figure(7);
                set(fig5,'Position', [700, 700, 1200, 500]);
                subFig1 = subplot(1,2,1);
                %plot unsorted data
                plotSequences(db(iexp), dfbf_timeLockedCells(:,:,window), trialPhase, 'Frames', 'Unsorted Cells', figureDetails, 1)
                subFig2 = subplot(1,2,2);
                %plot sorted data
                plotSequences(db(iexp), dfbf_sorted_timeCells(:,:,window), trialPhase, 'Frames', 'Sorted Cells', figureDetails, 1)
                print(['/Users/ananth/Desktop/figs/sort/timeCells_allTrialsAvg_sorted_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session)],...
                    '-djpeg');
                
                fig6 = figure(6);
                clf
                set(fig6,'Position',[300,300,1200,500])
                %plot sorted data
                plotdFbyF(db(iexp), dfbf_2D_sorted_timeCells, trialDetails, 'Frames', 'Sorted Cells', figureDetails, 1)
                print(['/Users/ananth/Desktop/figs/calciumActivity/dfbf_allTrials_' ...
                    db(iexp).mouse_name '_' num2str(db(iexp).sessionType) '_' num2str(db(iexp).session) '_sorted'],...
                    '-djpeg');
            end
        end
    end
end
%toc
%% Data Saving for Custom section

%%
disp('All done!')
beep
%% STRUCTURE OF RESULTS FILE
% cell traces are in dat.Fcell
% neuropil traces are in dat.FcellNeu
% manual, GUI overwritten "iscell" labels are in dat.cl.iscell
%
% stat(icell) contains all other information:
% iscell: automated label, based on anatomy
% neuropilCoefficient: neuropil subtraction coefficient, based on maximizing the skewness of the corrected trace (ICA)
% st: are the deconvolved spike times (in frames)
% c:  are the deconvolved amplitudes
% kernel: is the estimated kernel
