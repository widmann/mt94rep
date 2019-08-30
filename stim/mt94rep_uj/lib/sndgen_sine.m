function sndgen_sine
% mt94rep - Generate sinusoidal sounds
% Copyright (c) 2019 Andreas Widmann, University of Leipzig
% Author: Andreas Widmann, widmann@uni-leipzig.de

sndDur = 0.2;
sndFs = 48000;
sndRise = 0.01;
t = ( 0:sndDur * sndFs - 1 ) / sndFs;
env = tukeywin( sndDur * sndFs, sndRise / (sndDur / 2 ) )';

freqArray = 440 * 2.^ ( ( -6:5 ) / 12 );

for iFreq = 1:length( freqArray )
    
    sndArray = sin( 2 * pi * freqArray( iFreq ) * t );
    sndArray = sndArray .* env;
    audiowrite( fullfile( '..', 'sine', sprintf( '%02d.wav', iFreq ) ), sndArray, sndFs )
    
end
