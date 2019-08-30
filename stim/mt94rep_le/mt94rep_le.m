function mt94rep_le( subj, cond, blockArray)
% mt94rep_md - Wrapper function
% Copyright (c) 2019 Andreas Widmann, University of Leipzig
% Author: Andreas Widmann, widmann@uni-leipzig.de

more off
addpath( '/usr/local/toolbox/ppdev-mex/Octave3LinuxFiles64' )
addpath( fullfile( pwd, 'lib' ) )

result = system( 'amixer sset Master playback 22 capture 0' ); % 75 dB SPL at 587 Hz FS with Sennheiser HD25 in lab 117
% result = system( 'amixer sset Master 36' ); % 75 dB SPL at 1000 Hz FS with Sennheiser HD25 in NCD lab MD
if result ~= 0
    error('Could not set loudness.')
end

if nargin < 2
    error( 'Not enough input arguments.' )
end

if nargin < 3 || isempty( blockArray )
    if cond < 5
    	blockArray = 1:3;
    else
    	blockArray = 1;
    end
end

if cond < 3 || cond > 4
    sndpath = 'shep';
else
    sndpath = 'sine';
end

for iSnd = 1:12
    sndArray( iSnd, : ) = audioread( fullfile( sndpath, sprintf( '%02d.wav', iSnd ) ) );
%    rms( iSnd ) = sqrt( mean( sndArray( iSnd, : ) .^ 2 ) );
end
%20 * log10( rms ) + 78.3

nBlocks = length( blockArray );
for iBlock = 1:nBlocks
    
    Cfg.filename = sprintf( '%02d-%d-%d.txt', subj, cond, blockArray( iBlock ) );
    fprintf( '***\n*** Block %s\n*** Press enter to continue or ctrl+c to cancel\n***\n', Cfg.filename )
    pause
    
    block( Cfg, sndArray )
    
end

end
