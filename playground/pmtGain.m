clear all

fontSize = 12;
sz = 140;

cv1 = nan(3,1);
cv2 = nan(3,1);

a1 = [];
b1 = [];

a2 = [];
b2 = [];

x = [250:350];
y = [150:350];

for cv = 4:5
    %for lp = 25:25:75
    for lp = 25
        %Details
        scanAmp = '1V';
        laserPower = lp;
        controlVoltage = cv;
        
        filename = ['flourescein_' scanAmp ...
            '_l' num2str(laserPower) 'p_p' ...
            num2str(controlVoltage) 'Vc'];
        
        %Read image
        try
            X = imread(['/Users/ananth/Desktop/gain/' filename '.tif'],2);
        catch
            warning([filename '.tif not found!'])
            continue
        end
        
        %Plot image
        figure(1);
        subplot(3,1,1)
        imagesc(X);
        %colormap(gray)
        title(['Control Voltage: 0.' num2str(controlVoltage) 'V | ' ...
            ' LASER Power: ' num2str(laserPower) '%'], ...
            'FontSize', fontSize,...
            'FontWeight', 'bold')
        set(gca,'FontSize', fontSize)
        
        %Crop
        subplot(3,1,2)
        crop = X(x,y);
        imagesc(crop);
        colorbar
        title('Crop', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold');
        xlabel('Pixel Intensity (AU)', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        ylabel('Count', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', fontSize)
        
        %Plot histogram
        subplot(3,1,3)
        histogram(X);
        title('Histogram', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold');
        xlabel('Pixel Intensity (AU)', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        ylabel('Count', ...
            'FontSize', fontSize, ...
            'FontWeight', 'bold')
        set(gca,'FontSize', fontSize)
        print(['/Users/ananth/Desktop/gain/histogram', ...
            '_cv', num2str(controlVoltage), ...
            '_lp', num2str(laserPower)], '-djpeg')
        
        %Estimate mean and variance
        Y = reshape(crop,[length(x)*length(y),1]);
        Mv = mean(Y);
        Varv = var(double(Y));
        gain = Varv/Mv;
        Mn = Mv/gain; %Mean number of photons
        
        disp(['The gain of the PMT is: ' num2str(gain)])
        disp(['The mean number of photons is: ' num2str(Mn)])
        
        
        if cv == 4
            a1 = [a1 Varv];
            b1 = [b1 Mv];
        else
            a2 = [a2 Varv];
            b2 = [b2 Mv];
        end
    end
end

%Scatter Plots
% figure(2)
% scatter(b1,a1, ...
%     sz, ...
%     'bo', ...
%     'filled')
% % format long
% % %linFit1 = a1\b1;
% % %line = linFit1*b1;
% % plot(b1, linFit1*b1, 'blue', ...
% %     'LineWidth', lineWidth)
% hold on
% scatter(b2,a2, ...
%     sz, ...
%     'rd', ...
%     'filled')
% % format long
% % linFit2 = a2\b2;
% % plot(b2, linFit2*b2, 'red', ...
% %     'LineWidth', lineWidth)
% title('PMT Gain (AU/photon)', ...
%     'FontSize', fontSize, ...
%     'FontWeight', 'bold')
% xlabel('Mean Pixel Value', ...
%     'FontSize', fontSize, ...
%     'FontWeight', 'bold')
% ylabel('Variance of Pixel Values (Log))', ...
%     'FontSize', fontSize, ...
%     'FontWeight', 'bold')
% legend('Control Voltage: 0.4V','Control Voltage: 0.5V')
% set(gca,'FontSize', fontSize)
% print('/Users/ananth/Desktop/gain/scatterPlot', '-djpeg')