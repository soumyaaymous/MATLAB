clear all


fontSize = 12;

%Details
scanAmp = '1V';
laserPower = 50;
controlVoltage = 4;

filename = ['flourescein_' scanAmp ...
    '_l' num2str(laserPower) 'p_p' ...
     num2str(controlVoltage) 'Vc'];

%Read image
X = imread(['/Users/ananth/Desktop/gain/' filename '.tif'],1);
 
%Plot image
figure(1);
subplot(4,4,1:8)
imagesc(X);
%colormap(gray)
title(['8-bit Image - ' num2str(controlVoltage) 'V'])
set(gca,'FontSize', fontSize)

%Plot histogram
subplot(4,4,9:16)
histogram(X);
title('Histogram');
set(gca,'FontSize', fontSize)
xlabel('Pixel Intensities (AU)', ...
            'FontSize', fontSize,...
            'FontWeight', 'bold')
ylabel('Counts', ...
            'FontSize', fontSize,...
            'FontWeight', 'bold')        
set(gca,'FontSize', fontSize)

%Estimate mean and variance
Y = reshape(X,[512*512,1]);
Mv = mean(Y);
Varv = var(double(Y));
gain = Varv/Mv;
Mn = Mv/gain; %Mean number of photons

disp(['The gain of the PMT is: ' num2str(gain)])
disp(['The mean number of photons is: ' num2str(Mn)])