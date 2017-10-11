% Cartoons for poster
%close all
clear all

%Normal sequence
A = zeros(3,3);
for i = 1:3
    A(i,i) = 1;
end

%Double sequence
B = zeros(3,6);
for i = 1:3
    B(i,i) = 1;
    B(i,i+3) = 1;
end

%Extended sequence
C = zeros(6,6);
for i = 1:6
    C(i,i) = 1;
end

%No sequence
D = zeros(3,3);

fontSize = 40;
lineWidth = 2;
markerWidth = 7;
transparency = 0.5;

%% Plot1
% fig1 = figure(1); % ISI change
% set(fig1,'Position', [100, 100, 1200, 800]);
% subplot(1,3,1)
figure(1)
imagesc(A);
colormap('jet')
set(gca,'XTick', [1, 2, 3])
set(gca,'XTickLabel',{1; 2; 3})
xlabel('Time', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
set(gca,'YTick',[1, 2, 3])
set(gca,'YTickLabel',({1; 2; 3}))
ylabel('Cells', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
z = colorbar;
set(z,'YTick',[0, 1])
set(z,'YTickLabel',({'0', '1'}))
ylabel(z,'Probability of Firing', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', fontSize-2)
print('/Users/ananth/Desktop/nas/normalSequence','-djpeg');

%subplot(1,3,2)
figure(2)
imagesc(B);
colormap('jet')
set(gca,'XTick', [1, 2, 3, 4, 5, 6])
set(gca,'XTickLabel',{1; 2; 3; 4; 5; 6})
xlabel('Time', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
set(gca,'YTick',[1, 2, 3])
set(gca,'YTickLabel',({1; 2; 3}))
ylabel('Cells', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
z = colorbar;
set(z,'YTick',[0, 1])
set(z,'YTickLabel',({'0', '1'}))
ylabel(z,'Probability of Firing', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', fontSize-2)
print('/Users/ananth/Desktop/nas/doubleSequence','-djpeg');

%subplot(1,3,3)
figure(3);
imagesc(C);
colormap('jet')
set(gca,'XTick', [1, 2, 3, 4, 5, 6]) %NOTE: Starting 5 frames are skipped
set(gca,'XTickLabel',{1; 2; 3; 4; 5; 6}) %NOTE: At 200 fps, every frame is a 5 ms timestep.
xlabel('Time', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
set(gca,'YTick',[1, 2, 3, 4, 5, 6])
set(gca,'YTickLabel',({1; 2; 3; 4; 5; 6}))
ylabel('Cells', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
z = colorbar;
set(z,'YTick',[0, 1])
set(z,'YTickLabel',({'0', '1'}))
ylabel(z,'Probability of Firing', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', fontSize-2)
print('/Users/ananth/Desktop/nas/longerSequence','-djpeg');

%% Plot2
% fig2 = figure(2); % ISI change
% set(fig2,'Position', [100, 100, 1200, 800]);
% subplot(1,3,1)
% imagesc(A);
% colormap('jet')
% set(gca,'XTick', [1, 2, 3])
% set(gca,'XTickLabel',{1; 2; 3})
% xlabel('Time', ...
%     'FontSize', fontSize,...
%     'FontWeight', 'bold')
% set(gca,'YTick',[1, 2, 3])
% set(gca,'YTickLabel',({1; 2; 3}))
% ylabel('Cells', ...
%     'FontSize', fontSize,...
%     'FontWeight', 'bold')
% z = colorbar;
% set(z,'YTick',[0, 1])
% set(z,'YTickLabel',({'0', '1'}))
% ylabel(z,'Probability of Firing', ...
%     'FontSize', fontSize, ...
%     'FontWeight', 'bold')
% set(gca,'FontSize', fontSize-2)

% subplot(1,3,2)
% imagesc(A);
% colormap('jet')
% set(gca,'XTick', [1, 2, 3])
% set(gca,'XTickLabel',{1; 2; 3})
% xlabel('Time', ...
%     'FontSize', fontSize,...
%     'FontWeight', 'bold')
% set(gca,'YTick',[1, 2, 3])
% set(gca,'YTickLabel',({1; 2; 3}))
% ylabel('', ...
%     'FontSize', fontSize,...
%     'FontWeight', 'bold')
% z = colorbar;
% set(z,'YTick',[0, 1])
% set(z,'YTickLabel',({'0', '1'}))
% % ylabel(z,'Probability of Firing', ...
% %     'FontSize', fontSize, ...
% %     'FontWeight', 'bold')
% set(gca,'FontSize', fontSize-2)

%subplot(1,3,3)
figure(4)
imagesc(A);
colormap('jet')
set(gca,'XTick', [1, 2, 3])
set(gca,'XTickLabel',{1; 2; 3})
xlabel('Time', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
set(gca,'YTick',[1, 2, 3])
set(gca,'YTickLabel',({4; 5; 6}))
ylabel('Cells', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
z = colorbar;
set(z,'YTick',[0, 1])
set(z,'YTickLabel',({'0', '1'}))
ylabel(z,'Probability of Firing', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', fontSize-2)
print('/Users/ananth/Desktop/nas/differentSequence','-djpeg');

figure(5)
imagesc(D*-1);
colormap('jet')
set(gca,'XTick', [1, 2, 3])
set(gca,'XTickLabel',{1; 2; 3})
xlabel('Time', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
set(gca,'YTick',[1, 2, 3])
set(gca,'YTickLabel',({1; 2; 3}))
ylabel('Cells', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
z = colorbar;
set(z,'YTick',[0, 1])
set(z,'YTickLabel',({'0', '1'}))
ylabel(z,'Probability of Firing', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize', fontSize-2)
print('/Users/ananth/Desktop/nas/noSequence','-djpeg');