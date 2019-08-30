function sndck
% Copyright (c) 2019 Andreas Widmann, University of Leipzig
% Author: Andreas Widmann, widmann@uni-leipzig.de

more off
addpath( fullfile( pwd, 'lib' ) )
pkg load signal

result = system( 'amixer sset Master playback 22 capture 0' ); % 75 dB SPL at 587 Hz FS with Sennheiser HD25 in lab 117
% result = system( 'amixer sset Master 36' ); % 75 dB SPL at 1000 Hz FS with Sennheiser HD25 in NCD lab MD
if result ~= 0
    error('Could not set loudness.')
end

test_snd = repmat( audioread( fullfile( 'sine', '12.wav' ) )', [ 2 1 ] );

Cfg.initppa = 1;
Cfg.snddur = size( test_snd, 2 );
Cfg.sndfs = 48000;
Cfg.sndnchans = 2;
Cfg.sndreqlatclass = 2;
Cfg.sndsuglat = 0.005;
 
% Init PsychPortAudio
InitializePsychSound(1) % Start PsychSound in low latency mode
% pahandle = PsychPortAudio('Open' [, deviceid][, mode][, reqlatencyclass][, freq][, channels][, buffersize][, suggestedLatency][, selectchannels]);
Cfg.pahandle = PsychPortAudio('Open', [], 1, Cfg.sndreqlatclass, Cfg.sndfs, Cfg.sndnchans, [], Cfg.sndsuglat);

% Hot standby mode
% [underflow, nextSampleStartIndex, nextSampleETASecs] = PsychPortAudio('FillBuffer', pahandle, bufferdata [, streamingrefill=0][, startIndex=Append]);
PsychPortAudio('FillBuffer', Cfg.pahandle, test_snd );
% oldRunMode = PsychPortAudio('RunMode', pahandle [,runMode]);
PsychPortAudio('RunMode', Cfg.pahandle, 1); % Set sound device in 'hot standby' mode
% startTime = PsychPortAudio('Start', pahandle [, repetitions=1] [, when=0] [, waitForStart=0] [, stopTime=inf]);
PsychPortAudio('Start', Cfg.pahandle, 1, inf, 0); % Start sound playback with inf delay

keyCode = [];
fprintf( '***\n*** Sound from both headphone speakers in equal and acceptable loudness?\n*** Press enter to continue.\n***\n' )

while all( keyCode == 0 )

    % Play sound
    tSnd = PsychPortAudio('RescheduleStart', Cfg.pahandle, 0, 1);
    WaitSecs( 'YieldSecs', Cfg.snddur / Cfg.sndfs );

    % Wait for 500 ms or key press
    [ secs, keyCode ] = KbWait( [], [], GetSecs + 0.5 );

end

PsychPortAudio( 'Close' )
