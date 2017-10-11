function window = findWindow(trialPhase,sessionType,frameRate)    
    if strcmp(trialPhase, 'Pre')
        On = 1;
        Off = floor(preDuration*frameRate);
    end
    %frames
    %CS
    csOnFrame = floor(preDuration*frameRate) + 1;
    csOffFrame = csOnFrame + floor(csDuration*frameRate);
    %trace
    traceOnFrame = csOffFrame + 1;
    traceOffFrame = traceOnFrame + floor(traceDuration*frameRate);
    % US
    usOnFrame = traceOffFrame + 1;
    usOffFrame = usOnFrame + floor(usDuration*frameRate);
    
    % CS + Trace + USimagesc(stimWindow_trialAvg)
    window = csOnFrame:usOffFrame;
end