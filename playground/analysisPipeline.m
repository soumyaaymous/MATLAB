% Analysis pipeline example

imageProcessDirec = '/Users/ananth/Desktop/Work/Analysis/Behaviour/ImageProcess/';

sessionType = 9;
mice = 11;
session = 3;

dataset = [mouseName '_' num2str(sessionType) '_' num2str(session)];
load([imageProcessDirec mouseName '/' dataset '/imageProcess.mat'])

%1 - Load the reference image (first image in Trial 1)
file = [rawDirec mouseName '/' dataset '/trial_001.tif'];
refImage = double(imread(file, 1));

%2 - Crop image - for eye (absolute coordinates)
croppedImage = imcrop(refImage,crop);

%3 - Crop again - for FEC (relative coordinates)
fecImage = imcrop(croppedImage,fecROI);

%4 - Binarize
%threshold = prctile(reshape(fecImage,[((height2+1)*(width2+1)),1]),50);
fecImage_vector = reshape(fecImage,1,[]);
threshold = prctile(fecImage_vector,50);
binImage = fecImage > threshold; %binarize


fig1 = figure(1);
set(fig1,'Position', [100, 100, 600, 400]);
subplot(2,2,1)
imagesc(refImage)
z = colorbar;
ylabel(z,'Intensity (A.U.)', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
title('1. Original', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize',fontSize)

subplot(2,2,2)
imagesc(croppedImage)
z = colorbar;
ylabel(z,'Intensity (A.U.)', ...
    'FontSize', fontSize,...
    'FontWeight', 'bold')
title('2. Cropped', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize',fontSize)

subplot(2,2,3)
imagesc(fecImage)
colormap(gray)
z = colorbar;
ylabel(z,'Intensity (A.U.)', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
title('3. FEC ROI', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize',fontSize)

subplot(2,2,4)
imagesc(binImage);
colormap(gray)
z = colorbar;
ylabel(z,'Intensity (A.U.)', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
title('4. Binarized', ...
    'FontSize', fontSize, ...
    'FontWeight', 'bold')
set(gca,'FontSize',fontSize)