function block( Cfg, sndArray )
% mt94rep - Main block function
% Copyright (c) 2019 Andreas Widmann, University of Leipzig
% Author: Andreas Widmann, widmann@uni-leipzig.de

SOA = 0.45;

% Stim Linux
Cfg.trigfun = @sendtrigger_GLNXA64;
ppdev_mex('Open', 1);

% Development
% Cfg.trigfun = @sendtrigger_DUMMY;

Cfg.sndfs = 48000;
Cfg.sndnchans = 2;
Cfg.snddur = 0.2;
Cfg.sndreqlatclass = 3;
Cfg.sndsuglat = 0.005;

% Init PsychPortAudio
InitializePsychSound(1) % Start PsychSound in low latency mode
% pahandle = PsychPortAudio('Open' [, deviceid][, mode][, reqlatencyclass][, freq][, channels][, buffersize][, suggestedLatency][, selectchannels]);
Cfg.pahandle = PsychPortAudio('Open', [], 1, Cfg.sndreqlatclass, Cfg.sndfs, Cfg.sndnchans, [], Cfg.sndsuglat);

% Hot standby mode
% [underflow, nextSampleStartIndex, nextSampleETASecs] = PsychPortAudio('FillBuffer', pahandle, bufferdata [, streamingrefill=0][, startIndex=Append]);
PsychPortAudio('FillBuffer', Cfg.pahandle, zeros(Cfg.sndnchans, round(Cfg.sndfs * Cfg.snddur)));
% oldRunMode = PsychPortAudio('RunMode', pahandle [,runMode]);
PsychPortAudio('RunMode', Cfg.pahandle, 1); % Set sound device in 'hot standby' mode
% startTime = PsychPortAudio('Start', pahandle [, repetitions=1] [, when=0] [, waitForStart=0] [, stopTime=inf]);
PsychPortAudio('Start', Cfg.pahandle, 1, inf, 0); % Start sound playback with inf delay

% Load trial definitions
trialArray = dlmread( fullfile( 'trialdef', Cfg.filename ) );
nTrials = size( trialArray, 1 );

% Block start trigger
Cfg.trigfun( 254 )
tBlock = GetSecs;
t0 = tBlock;

% for iTrial = 1:50
for iTrial = 1:nTrials
    
    % Prepare sound
    PsychPortAudio('RefillBuffer', Cfg.pahandle, 0, repmat( sndArray( trialArray( iTrial, 2 ), : ), [ 2 1 ] ) );
    
    % Play sound
    t0 = PsychPortAudio('RescheduleStart', Cfg.pahandle, t0 + SOA, 1);
    Cfg.trigfun( trialArray( iTrial, 4 ) )
    
    % Log
    trialArray(iTrial, 5) = t0 - tBlock;
    fprintf( '%3d %2d %d %2d %.2f\n', trialArray( iTrial, : ) )
    
    % ISI
    WaitSecs('YieldSecs', Cfg.snddur );
    
end

% Block end trigger
WaitSecs('YieldSecs', 1);
Cfg.trigfun( 255 )

% Save data
dlmwrite( fullfile( 'log', Cfg.filename ), trialArray, 'delimiter', '\t', 'precision', '%g' );

% Clean up
PsychPortAudio( 'Close' )
ppdev_mex( 'Close', 1 );
