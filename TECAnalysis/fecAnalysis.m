% AUTHOR - Kambadur Ananthamurthy
% PURPOSE - FEC analysis
% DEPENDENCIES - Find the image processing parameters using findTheEye.m
%              - mseb.m (for plotting shaded error bars; open-source)

tic
clear all
%close all

addpath('/Users/ananth/Documents/MATLAB/CustomFunctions')

% Operations (0 == Don't Perform; 1 == Perform)
saveData = 0;
doFECAnalysis = 1;
smoothenStimuli = 1;
alignFrames = 1;
plotFigures = 1;
playVideo = 0;

% Dataset details
sessionType = 9;
%mice = [7 8 9 10];
mice = 11;
nSessions = 3;
nTrials = 61;

% Video details
nFrames = 270; %per trial; arbitrary

startSession = nSessions; %single sessions
%startSession = 5;
startTrial = 1;
startFrame = 1;

imageProcessDirec = '/Users/ananth/Desktop/Work/Analysis/VideoAnalysis/ImageProcess/';
%rawDirec = '/Users/ananth/Desktop/Work/Behaviour/DATA/';
rawDirec = '/Volumes/ananthamurthy/EyeBlinkBehaviour/';
motionDirec = '/Users/ananth/Desktop/Work/Analysis/MotionAnalysis/';
performanceDirec = '/Users/ananth/Desktop/Work/Analysis/PerformanceAnalysis/';
saveDirec = '/Users/ananth/Desktop/Work/Analysis/VideoAnalysis/FEC/';

if ~exist(rawDirec, 'dir')
    warning('Raw directory not found')
    return
end

fontSize = 16;
lineWidth = 2;
markerWidth = 7;
transparency = 0.5;

for mouse = 1:length(mice)
    mouseName = ['M' num2str(mice(mouse))];
    %mouseName = ['G5-' num2str(mice(mouse))];
    
    for session = startSession:nSessions
        dataset = [mouseName '_' num2str(sessionType) '_' num2str(session)];
        disp(['Working on ' dataset])
        
        if doFECAnalysis == 1
            disp('Performing FEC analysis ...')
            
            % Load image processing parameters
            load([imageProcessDirec mouseName '/' dataset '/imageProcess.mat'])
            
            % Preallocation - for every individual session
            eyeClosure = nan(nTrials,nFrames);
            eyeClosure_baseline = nan(nTrials,1);
            fec = nan(nTrials,nFrames);
            probeTrials = zeros(nTrials,1);
            timestamps = nan(nTrials,nFrames);
            trialCount = nan(nTrials,nFrames);
            puff = zeros(nTrials,nFrames);
            tone = zeros(nTrials,nFrames);
            led = zeros(nTrials,nFrames);
            motion1 = zeros(nTrials,nFrames);
            motion2 = zeros(nTrials,nFrames);
            camera = zeros(nTrials,nFrames);
            microscope = zeros(nTrials,nFrames);
            
            % Analyze every trial for FEC
            for trial = startTrial:nTrials
                disp(['Trial ' num2str(trial) '/' num2str(nTrials)])
                
                if trial <10
                    file = [rawDirec mouseName '/' dataset, ...
                        '/trial_00' num2str(trial) '.tif'];
                else
                    file = [rawDirec mouseName '/' dataset, ...
                        '/trial_0' num2str(trial) '.tif'];
                    
                    if (mod(trial,10) == 0) && trial ~= nTrials
                        disp(['... working on ' dataset ' ...'])
                    end
                end
                
                for frame = startFrame:nFrames
                    %1 - Load the reference image (first image in Trial 1)
                    try
                        refImage = double(imread(file, frame));
                    catch
                        warning(['Unable to find Frame: ' num2str(frame)])
                        continue
                    end
                    
                    %2 - Crop image - for eye (absolute coordinates)
                    croppedImage = imcrop(refImage,crop);
                    
                    %3 - Crop again - for FEC (relative coordinates)
                    fecImage = imcrop(croppedImage,fecROI);
                    
                    %4 - Binarize
                    % The "threshold" is established by "findTheEye.m"
                    binImage = fecImage > threshold; %binarize
                    
                    binImage_vector = reshape(binImage,1,[]);
                    eyeClosure(trial,frame) = (length(find(~binImage)))/length(binImage_vector);
                    
                    % Read Datalines from each frame
                    dataLine = char(refImage(1,:));
                    %disp(dataLine)
                    commai = strfind(dataLine,',');
                    
                    if isempty(commai)
                        %warning(['Frame ' num2str(frame) ' has no data line'])
                        continue
                    else
                        %{
                        DATALINE:
                        1. msg_
                        2. "%lu,%d,%d,%d,%d,%d,%d,%d,%d,%s"
                        3. timestamp
                        4. trial_count_
                        5. puff
                        6. tone
                        7. led,
                        8. motion1
                        9. motion2
                        10. camera
                        11. microscope
                        12. trial_state_
                        %}
                        timestamps(trial,frame) = str2double(sprintf(dataLine(commai(2)+1:commai(3)-1),'%s'));
                        trialCount(trial,frame) = str2double(sprintf(dataLine(commai(3)+1:commai(4)-1),'%s'));
                        if trialCount(trial,frame) ~= trial
                            warning('trialCount ~= trial')
                        end
                        puff(trial,frame)= str2double(sprintf(dataLine(commai(4)+1:commai(5)-1),'%s'));
                        %tone(trial,frame) = str2double(sprintf(dataLine(commai(5)+1:commai(6)-1),'%s'));
                        led(trial,frame) = str2double(sprintf(dataLine(commai(6)+1:commai(7)-1),'%s'));
                        motion1(trial,frame) = str2double(sprintf(dataLine(commai(7)+1:commai(8)-1),'%s'));
                        motion2(trial,frame) = str2double(sprintf(dataLine(commai(8)+1:commai(9)-1),'%s'));
                        camera(trial,frame) = str2double(sprintf(dataLine(commai(9)+1:commai(10)-1),'%s'));
                        microscope(trial,frame) = str2double(sprintf(dataLine(commai(10)+1:commai(11)-1),'%s'));
                    end
                    
                    if playVideo == 1
                        if frame == startFrame
                            disp('Playing Video ...');
                        end
                        pause(0.05)
                        fig2 = figure(2);
                        set(fig2,'Position', [100, 100, 600, 450]);
                        subplot(1,3,1)
                        imagesc(croppedImage)
                        colormap(gray)
                        z = colorbar;
                        ylabel(z,'Intensity (A.U.)', ...
                            'FontSize', fontSize,...
                            'FontWeight', 'bold')
                        title(['Eye - ' mouseName ...
                            ' ST' num2str(sessionType) ' S' num2str(session) ...
                            ' Trial ' num2str(trial) ...
                            ' Frame ' num2str(frame)], ...
                            'FontSize', fontSize, ...
                            'FontWeight', 'bold')
                        
                        subplot(1,3,2)
                        imagesc(fecImage)
                        colormap(gray)
                        z = colorbar;
                        ylabel(z,'Intensity (A.U.)', ...
                            'FontSize', fontSize, ...
                            'FontWeight', 'bold')
                        title(['Binarized Frame ' num2str(frame)], ...
                            'FontSize', fontSize, ...
                            'FontWeight', 'bold')
                        
                        subplot(1,3,3)
                        imagesc(binImage)
                        colormap(gray)
                        z = colorbar;
                        ylabel(z,'Intensity (A.U.)', ...
                            'FontSize', fontSize, ...
                            'FontWeight', 'bold')
                        title(['fecROI Frame ' num2str(frame)], ...
                            'FontSize', fontSize, ...
                            'FontWeight', 'bold')
                    end
                    %close(2)
                end
                
                eyeClosure_baseline(trial) = max(eyeClosure(trial,:));
                fec(trial,:) = 1 - (eyeClosure(trial,:)/eyeClosure_baseline(trial));
                
                % Probe Trials
                puffi = find(puff(trial,:));
                if isempty(puffi)
                    probeTrials(trial,1) = 1;
                    disp('Probe trial found!')
                end
                
                disp('... done')
            end
        else
            load([saveDirec mouseName '/' dataset '/fec.mat']);
            %load([motionDirec mouseName '/' dataset '/motion.mat']);
            %load([performanceDirec mouseName '/' dataset '/performance.mat']);
        end
        
        if smoothenStimuli == 1
            disp('Smoothening stimuli ...')
            %Smoothen (on account of missing data lines)
            %LED
            for trial = startTrial:nTrials
                ledi = find(led(trial,:));
                if isempty(ledi)
                    warning(['There is no CS played in trial ' num2str(trial)])
                    continue
                else
                    led(trial,ledi(1):ledi(end)) = 1;
                end
                
                %Puff
                puffi = find(puff(trial,:));
                if isempty(puffi)
                    warning(['There is no US played in trial ' num2str(trial)])
                    continue
                else
                    puff(trial,puffi(1):puffi(end)) = 1;
                end
            end
        end
        
        if alignFrames == 1
            csStartFrame = nan(nTrials,1);
            csStartOffset = nan(nTrials,1);
            usStartFrame = nan(nTrials,1);
            nISIFrames = nan(nTrials,1);
            
            %Aligned matrices
            alignedFEC = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedPuff = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedLED = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedMotion1 = nan(nTrials,(nFrames-10)); % -5 on each end
            alignedMotion2 = nan(nTrials,(nFrames-10)); % -5 on each end
            
            for trial = 1:nTrials
                csStartFrame(trial) = find(led(trial,:),1);
                %meanCSStartFrame = floor(mean(csStartFrame,1));
                csStartOffset(trial) = csStartFrame(trial) - 101; %assuming ~200 fps
                %fec
                alignedFEC(trial,:) = fec(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                %puff
                alignedPuff(trial,:) = puff(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                %led
                alignedLED(trial,:) = led(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                %motion1
                alignedMotion1(trial,:) = motion1(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
                %motion2
                alignedMotion1(trial,:) = motion2(trial,(5+csStartOffset(trial)):((end-6)+csStartOffset(trial)));
            end
            FEC = alignedFEC;
            PUFF = alignedPuff;
            LED = alignedLED;
            MOTION1 = alignedMotion1;
            MOTION2 = alignedMotion2;
        else
            FEC = fec;
            PUFF = puff;
            LED = led;
            MOTION1 = motion1;
            MOTION2 = motion2;
        end
        
        if plotFigures == 1
            % FEC plots
            fig4 = figure(4);
            set(fig4,'Position', [100, 100, 1200, 800]);
            clf
            %subplot(6,9,1:45)
            subplot(2,2,1)
            imagesc(FEC)
            colormap(jet)
            if sessionType == 9
                title([mouseName ' S' num2str(session) ' | 250 ms Trace | FEC '], ...
                    'FontSize', fontSize, ...
                    'FontWeight', 'bold')
            else
                title([' FEC | 350 ms Trace | ' mouseName ' S' num2str(session)], ...
                    'FontSize', fontSize, ...
                    'FontWeight', 'bold')
            end
            
            set(gca,'XTick', [])
            set(gca,'XTickLabel', [])
            ylabel('Trials', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            z = colorbar;
            set(z,'YTick',[0, 1])
            set(z,'YTickLabel',({'Open', 'Closed'}))
            set(gca,'FontSize', fontSize-2)
            
            % Stimuli
            subplot(2,2,3)
            stimuli = alignedLED+(2*alignedPuff);
            imagesc(stimuli)
            colormap(jet)
            title('Stimuli', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'XTick', [])
            set(gca,'XTickLabel', [])
            ylabel('Trials', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            z = colorbar;
            set(z,'YTick',[0, 1, 2])
            set(z,'YTickLabel',({'Off'; 'LED'; 'Puff'}))
            set(gca,'FontSize', fontSize-2)
            
            
            % Probe Trials
            subplot(2,2,2)
            imagesc(probeTrials)
            colormap(jet)
            title('Probe Trials', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'XTick', [])
            set(gca,'XTickLabel', [])
            ylabel('Trials', ...
                'FontSize', fontSize,...
                'FontWeight', 'bold')
            z = colorbar;
            set(z,'YTick',[0, 1])
            set(z,'YTickLabel',({'No'; 'Yes'}))
            set(gca,'FontSize', fontSize-2)
            
            % Shaded error bars
            notProbes = find(~probeTrials);
            meanFEC = nanmean(FEC(notProbes,:),1);
            meanFEC_stddev = nanstd(FEC(notProbes,:),1);
            probes = find(probeTrials);
            meanFEC_probe = nanmean(FEC(probes,:),1);
            meanFEC_probe_stddev = nanstd(FEC(probes,:),1);
            
            subplot(2,2,4)
            lineProps1.col{1} = 'red';
            lineProps2.col{1} = 'green';
            mseb([],meanFEC, meanFEC_stddev,...
                lineProps1, transparency);
            hold on
            mseb([],meanFEC_probe, meanFEC_probe_stddev,...
                lineProps2, transparency);
            ylabel('FEC', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            title('CS+US vs Probe Trials', ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
            set(gca,'XTick', [])
            set(gca,'XTickLabel', [])
            set(gca,'YTick',[0, 1])
            set(gca,'YTickLabel',({0; 1}))
            set(gca,'FontSize', fontSize-2)
            legend('mean Paired +/- stddev', 'mean Probe +/- stddev','Location', 'northwest')
            
            print(['/Users/ananth/Desktop/figs/FEC/fec_' ...
                mouseName '_' num2str(sessionType) '_' num2str(session)],...
                '-djpeg');
            
        end
        
        if saveData == 1
            saveFolder = [saveDirec mouseName '/' dataset '/'];
            if ~isdir(saveFolder)
                mkdir(saveFolder);
            end
            
            % Save FEC curve
            save([saveFolder 'fec.mat' ], ...
                'eyeClosure', 'fec', ...
                'led', 'puff', ...
                'motion1', 'motion2', ...
                'csStartOffset', ...
                'alignedFEC', 'alignedLED', 'alignedPuff',...
                'alignedMotion1', 'alignedMotion2', ...
                'probeTrials',...
                'camera', 'microscope', ...
                'crop', 'fecROI')
        end
        disp([dataset ' analyzed'])
    end
end
toc
beep
disp('All done!')
