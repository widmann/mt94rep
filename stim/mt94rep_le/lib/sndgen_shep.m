function sndgen_shep
% mt94rep - Generate Shepard sounds
% Copyright (c) 2019 Andreas Widmann, University of Leipzig
% Author: Andreas Widmann, widmann@uni-leipzig.de

sndDur = 0.2;
sndFs = 48000;
sndRise = 0.01;
t = ( 0:sndDur * sndFs - 1 ) / sndFs;
env = tukeywin( sndDur * sndFs, sndRise / (sndDur / 2 ) )';

fMin = 9.725;
Lmax = -19;
Lmin = -34 - 19;
nComp = 10;

f0 = fMin * ( 2 ^ ( 1 / 12 ) ) .^ [ 0 1 2 3 4 5 6 7 8 9 10 11 ];
f = f0' * 2 .^ ( 0:nComp - 1 );
th = 2 * pi * log2( f / fMin ) / nComp;
A = 10 .^ ( ( Lmin + ( Lmax - Lmin ) * ( 1 - cos( th ) ) / 2 ) / 20 );

sndArray = zeros( size( f, 1 ), sndDur * sndFs );

for iSnd = 1:size( f, 1 )
    for iComp = 1:size( f, 2 )
        sndArray( iSnd, : ) = sndArray( iSnd, : ) + A( iSnd, iComp ) * sin( 2 * pi * f( iSnd, iComp ) * t );
    end
    sndArray( iSnd, : ) = sndArray( iSnd, : ) .* env;
end

% sndArray = sndArray / max( max( abs( sndArray ) ) ); % Normalize

max( abs( sndArray' ) )
sqrt( mean( sndArray' .^ 2 ) )

for iSnd = 1:size( f, 1 )
    audiowrite( fullfile( '..', 'shep', sprintf( '%02d.wav', iSnd ) ), sndArray( iSnd, : ), sndFs )
end
