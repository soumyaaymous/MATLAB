clear all
%close all

%Operations
loadTiff = 0;
checkAvgImage = 0;
playMovie = 0;
plotFigures = 1;

fontSize = 12;
lineWidth = 3;
markerSize = 8;

direc = '/Users/ananth/Desktop/beads/';

%Details
scanAmp = 'p05V';
xyres_pix2micron = 0.0463; % 21.5955 pixels = 1 um
zres_planes2micron = 0.5; % every subsequent plane is 0.5 um deeper
%laserPower = 'l10p';
%controlVoltage = 'cp4V';
%supplyVoltage = 's14p6V';

nPlanes = 40;
startPlane = 1;
nCopies = 5;

xpix = 128;
ypix = 128;

% xyres_xrange = 89;
% xyres_yrange = 70:80;
% zres_x = 88;
% zres_y = 73;
xyres_xrange = 89;
xyres_yrange = 72:80;
xyres_plane = 37;

zres_x = 79;
zres_y = 62;
zres_planes = 7:17;

allPlanes = zeros(xpix, ypix, nPlanes);
if loadTiff == 1
    %add directory to load tiff.
else
    outputFileName = [direc 'beads1_zStack.tif'];
    for plane = startPlane:nPlanes
        
        filename = ['beads1_' scanAmp '-z' num2str(plane) '.tif'];
        disp(filename)
        sumImage = zeros(xpix, ypix);
        
        for copy = 1:nCopies
            try
                image = double(imread([direc filename], copy));
            catch
                warning([filename ' not found!'])
                continue
            end
            sumImage = sumImage + image;
            avgImage = sumImage/nCopies;
        end
        
        allPlanes(:,:,plane) = avgImage;
        
        if checkAvgImage == 1
            figure(1)
            pause(0.3)
            imagesc(avgImage);
            title(['AvgImage for Plane ' num2str(plane), ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold'])
        end
        disp('Saving ...')
        imwrite(avgImage, outputFileName, ...
            'WriteMode', 'append',  'Compression','none');
        disp('...done!')
    end
    
    %Play z-stack movie
    if playMovie == 1
        disp('Playing z-stack movie ...')
        for plane = startPlane:nPlanes
            figure(2)
            pause(0.3)
            frame = allPlanes(:,:,plane);
            imagesc(frame);
            title(['Z-stack - Plane ' num2str(plane)], ...
                'FontSize', fontSize, ...
                'FontWeight', 'bold')
        end
        disp('...movie complete!')
    end
    
    %Resolution
    if plotFigures == 1
        figure(3)
        plot(squeeze(allPlanes(xyres_yrange, xyres_xrange, xyres_plane)), ...
            'LineWidth',lineWidth,...
            'MarkerSize',markerSize)
        title('Lateral Resolution', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        xlabel('Distance (um)', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        ylabel('Pixel Intensity (A.U.)', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', fontSize)
        %set(gca,'XTick', 1:2:length(xyres_yrange))
        set(gca,'XTickLabel', (1:2:length(xyres_yrange)+1)*xyres_pix2micron)
        print([direc 'lateralResolution'], ...
            '-djpeg')
        
        figure(4)
        plot(squeeze(allPlanes(zres_x,zres_y,zres_planes)), ...
            'LineWidth',lineWidth,...
            'MarkerSize',markerSize)
        title('Axial Resolution', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        xlabel('Distance (um)', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        ylabel('Pixel Intensity (A.U.)', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', fontSize)
        %set(gca,'XTick', 1:2:nPlanes)
        %set(gca,'XTickLabel',1:nPlanes*zres_planes2micron)
        set(gca,'XTickLabel',zres_planes*zres_planes2micron)
        print([direc 'axialResolution'], ...
            '-djpeg')
        %
        %         figure(5)
        %         imagesc(allPlanes(:,:,xyres_plane))
        %         colormap(gray)
        %         z = colorbar;
        %         ylabel(z,'Pixel Intensity (A.U.)',...
        %             'FontSize', fontSize,...
        %             'FontWeight', 'bold')
        %         title('0.2 um beads - 128x128 image', ...
        %             'FontSize', fontSize, ...
        %             'FontWeight', 'bold')
        %         set(gca,'FontSize', fontSize)
        
    end
end