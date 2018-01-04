function trialDetails = getTrialDetails_alt(dataset)

disp('Getting session details ...')

%Mehrab's data
trialDetails.frameRate          = round((dataset.nFrames/dataset.trialDuration),1);
trialDetails.preDuration        = 10.0000; %in seconds
trialDetails.csDuration         = 0.3500; %in seconds
trialDetails.usDuration         = 0.1000; %in seconds

if dataset.sessionType == 1 %250 ms trace
    trialDetails.traceDuration      = 0.2500; %in seconds

elseif dataset.sessionType == 2 %350 ms trace
    trialDetails.traceDuration      = 0.3500; %in seconds

elseif dataset.sessionType == 3 %500 ms trace
    trialDetails.traceDuration      = 0.5000; %in seconds 

elseif dataset.sessionType == 4 %No US; no trace
    trialDetails.traceDuration      = 0.0000; %in seconds

elseif dataset.sessionType == 5 %No US; no trace
    trialDetails.traceDuration      = 0.0000; %in seconds
else
    warning('Unknown session type')
end

trialDetails.postDuration = dataset.trialDuration - ...
    (trialDetails.preDuration + ...
    trialDetails.csDuration + ...
    trialDetails.traceDuration + ...
    trialDetails.usDuration); %in seconds

disp('... done!')