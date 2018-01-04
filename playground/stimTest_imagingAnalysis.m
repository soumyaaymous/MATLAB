direc = '/Users/ananth/Desktop/Work/Imaging/20171114/';
mouseName = 'stimTest';
sessionType = 1;
session = 1;
nTrials = 39;
nFrames = 246;

dataset = [mouseName '_' num2str(sessionType) '_' num2str(session)];

%Preallocation
Data = zeros(nTrials, nFrames);

for trial = 1:nTrials
    disp(['Trial ' num2str(trial) ' ...'])
    file = [direc dataset '-ROI/Trial' num2str(trial) '-ROI-1.tif'];
    for frame = 1:nFrames
        image = double(imread(file, frame));
        Data(trial, frame) = mean(mean(image));
    end
    disp('... done!')
end

%Figures
figure(1)
clf
imagesc(Data);
%colorbar
title('Stimulus Test')
xlabel('Frames')
ylabel('Trials')