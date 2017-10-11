% TEC learning - Representative examples

clear all
figure(1); clf; figure(2); clf
fontSize = 16;
lineWidth = 2;
markerWidth = 7;
transparency = 0.5;

%mouse = 'MouseM';
mouseName = 'M11';
sessionType = 11;
session = 2;

fecDirec = '/Users/ananth/Desktop/Work/Analysis/Behaviour/FEC/';

dataset = [mouseName '_' num2str(sessionType) '_' num2str(session)];
load([fecDirec mouseName '/' dataset '/fec.mat'])

%Stim lines
timeLine = zeros(260,1);
csLine = timeLine;
usLine = timeLine;
csLine(95:105,1) = 1;
if sessionType == 9
    usLine(155:165) = 1;
else
    usLine(205:215) = 1;
end

%%
fig1 = figure(1);
%set(fig1,'Position', [100, 100, 800, 300]);
clf
figure(1);
imagesc(FEC)
colormap(jet)
if sessionType == 9
    title([mouseName ' S' num2str(session) ' | 250 ms Trace | FEC '], ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
else
    title([' FEC | 500 ms Trace | ' mouseName ' S' num2str(session)], ...
        'FontSize', fontSize, ...
        'FontWeight', 'bold')
end
set(gca,'XTick', [35, 75, 115, 155, 195, 235]) %NOTE: Starting 5 frames are skipped
set(gca,'XTickLabel', ({200; 400; 600; 800; 1000; 1200})) %NOTE: At 200 fps, every frame is a 5 ms timestep.
% xlabel('Time/ms', ...
%     'FontSize', fontSize,...
%     'FontWeight', 'bold')
set(gca,'YTick',[10, 20, 30, 40, 50, 60])
set(gca,'YTickLabel',({10; 20; 30; 40; 50; 60}))
ylabel('Trials', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
z = colorbar;
set(z,'YTick',[0, 1])
set(z,'YTickLabel',({'Open', 'Closed'}))
set(gca,'FontSize', fontSize)

%set(fig2,'Position', [100, 100, 800, 300]);
notProbes = find(~probeTrials);
meanFEC = nanmean(FEC(notProbes,:),1);
meanFEC_stddev = nanstd(FEC(notProbes,:),1);
probes = find(probeTrials);
meanFEC_probe = nanmean(FEC(probes,:),1);
meanFEC_probe_stddev = nanstd(FEC(probes,:),1);
print(['/Users/ananth/Desktop/nas/fecExample1' ...
    mouseName '_' num2str(sessionType) '_' num2str(session)],...
    '-djpeg');


figure(2)
subplot(9,9,1:72)
lineProps1.col{1} = 'red';
lineProps2.col{1} = 'green';
mseb([],meanFEC, meanFEC_stddev,...
    lineProps1, transparency);
hold on
mseb([],meanFEC_probe, meanFEC_probe_stddev,...
    lineProps2, transparency);
title('CS+US vs Probe Trials', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'XTick', [35, 75, 115, 155, 195, 235]) %NOTE: Starting 5 frames are skipped
%set(gca,'XTickLabel', ({200; 400; 600; 800; 1000; 1200})) %NOTE: At 200 fps, every frame is a 5 ms timestep.
% xlabel('Time/ms', ...
%     'FontSize', fontSize,... 'FontWeight', 'bold')
set(gca,'YTick',[0, 1])
set(gca,'YTickLabel',({0; 1}))
ylabel('FEC', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', fontSize)
legend('mean Paired +/- stddev', 'mean Probe +/- stddev','Location', 'northwest')

subplot(9,9,73:81)
plot(csLine,'-','LineWidth',lineWidth)
hold on
plot(usLine,'-','LineWidth',lineWidth)
legend('CS','US')
set(gca,'FontSize', fontSize-2)
set(gca,'YTick',[0 1])
set(gca, 'YTickLabel', {'Off' 'On'})
xlabel('Time/ms', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
set(gca,'XTick', [35, 75, 115, 155, 195, 235]) %NOTE: Starting 5 frames are skipped
set(gca,'XTickLabel', ({200; 400; 600; 800; 1000; 1200})) %NOTE: At 200 fps, every frame is a 5 ms timestep.
set(gca,'FontSize', fontSize)

print(['/Users/ananth/Desktop/nas/meanExample1' ...
    mouseName '_' num2str(sessionType) '_' num2str(session)],...
    '-djpeg');
