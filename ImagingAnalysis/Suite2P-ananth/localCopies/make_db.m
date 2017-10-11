i = 0;

i = i+1; %1
db(i).mouse_name    = 'M11';
db(i).date          = '20170707';
db(i).sessionType   = 1;
db(i).session       = 6;
db(i).diameter      = 14;
db(i).scanAmplitude = '1.2V';
db(i).nFrames       = 171;
db(i).nTrials       = 44; %usable trials
db(i).comments      = '250 ms TEC';
db(i).trialDuration = 17; %in seconds
db(i).expts         = 1;
db(i).nplanes       = 1;
db(i).gchannel      = 1; 
db(i).nplanes       = 1; 
db(i).expred        = [];
db(i).nchannels_red = 0;

% i = i+1; %2
% db(i).mouse_name    = 'M11';
% db(i).date          = '20170711';
% db(i).expts         = 1;
% db(i).nplanes       = 1;
% db(i).diameter      = 40;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [];
% db(i).nchannels_red = 0;
% db(i).comments      = '250 ms TEC Session 4';

% i = i+1; %3
% db(i).mouse_name    = 'M11';
% db(i).date          = '20170712';
% db(i).expts         = 1;
% db(i).nplanes       = 1;
% db(i).diameter      = 40;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [];
% db(i).nchannels_red = 0;
% db(i).comments      = '500 ms TEC Session 1';
 
% i = i+1; %4
% db(i).mouse_name    = 'M11';
% db(i).date          = '20170713';
% db(i).expts         = 1;
% db(i).nplanes       = 1;
% db(i).diameter      = 40;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [];
% db(i).nchannels_red = 0;
% db(i).comments      = '500 ms TEC Session 2';

% db(i).mouse_name    = 'M11';
% db(i).date          = {'20170710', '20170711', '20170712', '20170713'};
% db(i).expts         = 1;
% db(i).nplanes       = 1;
% db(i).diameter      = 40;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [];
% db(i).nchannels_red = 0;
% db(i).comments      = '';

% example of datasets, which consist of several sessions - use cell arrays
% will be treated as subsets of experiment with the same FOV, with
% different names/dates (for one reason or another), analyzed together
% i = i+1;
% db(i).mouse_name    = {'MK020', 'M150416_MK020'};
% db(i).date          = {'2015-07-30', '2015-07-30'};
% db(i).expts         = {[2010 2107], [1 2 3]};
% db(i).diameter      = 12;

% i = i+1;
% db(i).mouse_name    = 'M11';
% db(i).date          = '20170711';
% db(i).expts         = [1];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [4];
% db(i).nchannels_red = 1;
% db(i).comments      = '';

% i = i+1;
% db(i).mouse_name    = 'M150329_MP009';
% db(i).date          = '2015-04-29';
% db(i).expts         = [4 5 6];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [3];
% db(i).nchannels_red = 2;
% db(i).comments      = 'multi p file: block 4,5,6';
% 
% i = i+1;
% db(i).mouse_name    = 'M150331_MP011';
% db(i).date          = '2015-04-29';
% db(i).expts         = [3 4 6];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [2];
% db(i).nchannels_red = 2;
% db(i).comments      = 'multi p file: block 4,3,6';
% 
% i = i+1;
% db(i).mouse_name    = 'M150422_MP012';
% db(i).date          = '2015-04-28';
% db(i).expts         = [3 4 5];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [2];
% db(i).nchannels_red = 2;
% db(i).comments      = 'multi p file: block 3,4,5';
% 
% i = i+1;
% db(i).mouse_name    = 'M150422_MP012';
% db(i).date          = '2015-05-04';
% db(i).expts         = [2 8];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).comments      = 'single p file: block 2';
% 
% i = i+1;
% db(i).mouse_name    = 'M150422_MP012';
% db(i).date          = '2015-05-20';
% db(i).expts         = [4];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [2];
% db(i).nchannels_red = 2;
% db(i).comments      = 'single p file: block 4';
% 
% i = i+1;
% db(i).mouse_name    = 'M150422_MP015';
% db(i).date          = '2015-05-09';
% db(i).expts         = [2 3];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1;
% db(i).expred        = [1];
% db(i).nchannels_red = 2;
% db(i).comments      = 'single p file, block 3';
% 
% % i = i+1;
% % db(i).mouse_name    = 'M150808_MP016';
% % db(i).date          = '2015-08-24';
% % db(i).expts         = [4];
% % db(i).nchannels     = 1;
% % db(i).gchannel      = 1; 
% % db(i).nplanes       = 1; 
% % db(i).expred        = [3];
% % db(i).nchannels_red = 2;
% % db(i).comments      = 'single p file, block 4, zoom 20';
% 
% i = i+1;
% db(i).mouse_name    = 'M150423_MP014';
% db(i).date          = '2015-06-16';
% db(i).expts         = [8];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1; 
% db(i).expred        = [4];
% db(i).nchannels_red = 2;
% db(i).comments      = 'single p file, block 8 + .3Hz stimulus';
% 
% i = i+1;
% db(i).mouse_name    = 'M150422_MP015';
% db(i).date          = '2015-05-01';
% db(i).expts         = [5 6];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1;
% db(i).expred        = [];
% db(i).nchannels_red = 2;
% db(i).comments      = 'only 1Hz vs 10Hz';
% 
% i = i+1;
% db(i).mouse_name    = 'M150331_MP011';
% db(i).date          = '2015-05-02';
% db(i).expts         = [4 7 8 10 11 12];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1;
% db(i).expred        = [3];
% db(i).nchannels_red = 2;
% db(i).comments      = 'first three running, last three not running';
% 
% i = i+1;
% db(i).mouse_name    = 'M150422_MP015';
% db(i).date          = '2015-04-28';
% db(i).expts         = [3 4 5];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1;
% db(i).expred        = [];
% db(i).nchannels_red = 2;
% db(i).comments      = 'might not be enough signal in this one!';
% 
% i = i+1;
% db(i).mouse_name    = 'M150808_MP016';
% db(i).date          = '2015-08-24';
% db(i).expts         = [4];
% db(i).nchannels     = 1;
% db(i).gchannel      = 1; 
% db(i).nplanes       = 1;
% db(i).expred        = 3;
% db(i).nchannels_red = 2;
% db(i).comments      = 'zoom 20x recording';
