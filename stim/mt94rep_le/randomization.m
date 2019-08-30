function randomization
% mt94rep_le - Trial randomization
% Copyright (c) 2019 Andreas Widmann, University of Leipzig
% Author: Andreas Widmann, widmann@uni-leipzig.de

subjArray = 1:20;
nSubj = length( subjArray );

condArray = 1:4;
nCond = 4;

blockArray = 1:3;
nBlocks = 3;

templateArray = { 1 [ 1 1 2 ] };

for iSubj = 1:nSubj
    
    rng( subjArray( iSubj ) )
    
    for iCond = 1:nCond
        
        for iBlock = 1:nBlocks
            
            switch condArray( iCond )
                
                case 1 % Shepard repetition
                    
                    trialArray = [ repmat( 12:-1:1, [ 1 50 ] ) 12:-1:8 ]';
                    trialArray( :, 2 ) = 1;
                    
                    typeArray = [ repmat( 1:12, [ 1 6 ] ) randsample( 1:12, 3 ) ];
                    typeArray = typeArray( randperm( length( typeArray ) ) );
                    
                    for iDev = 1:75
                        
                        type = typeArray( iDev );
                        exclArray = find( trialArray( :, 2 ) == 2 );
                        exclArray = [ 1; 2; exclArray - 2; exclArray - 1; exclArray; exclArray + 1; exclArray + 2 ];
                        candArray = setdiff( find( trialArray(:, 1 ) == type ), exclArray );
                        
                        evtIdx = randsample( candArray, 1 );
                        
                        trialArray = trialArray( [ 1:evtIdx evtIdx evtIdx + 1:end ], : );
                        trialArray( evtIdx + 1, 2 ) = 2;
                        
                    end
                    
                case 2 % Shepard ascending
                    
                    trialArray = [ repmat( 12:-1:1, [ 1 55 ] ) 12:-1:3 ]';
                    trialArray( :, 2 ) = 1;
                    
                    typeArray = [ repmat( 1:12, [ 1 6 ] ) randsample( 1:12, 3 ) ];
                    typeArray = typeArray( randperm( length( typeArray ) ) );
                    
                    for iDev = 1:75
                        
                        type = typeArray( iDev );
                        exclArray = find( trialArray( :, 2 ) == 2 );
                        exclArray = [ 1; 2; exclArray - 2; exclArray - 1; exclArray; exclArray + 1; exclArray + 2 ];
                        candArray = setdiff( find( trialArray(:, 1 ) == type ), exclArray );
                        
                        evtIdx = randsample( candArray, 1 );
                        
                        trialArray = trialArray( [ 1:evtIdx evtIdx - 1 evtIdx evtIdx + 1:end ], : );
                        trialArray( evtIdx + 1, 2 ) = 2;
                        
                    end
                    
                case 3 % sinusoidal repetition
                    
                    trialArray = [ repmat( 12:-1:1, [ 1 50 ] ) 12:-1:8 ]';
                    trialArray( :, 2 ) = 1;
                    
                    typeArray = [ repmat( 1:11, [ 1 6 ] ) randsample( 1:11, 9 ) ];
                    typeArray = typeArray( randperm( length( typeArray ) ) );
                    
                    for iDev = 1:75
                        
                        type = typeArray( iDev );
                        exclArray = find( trialArray( :, 2 ) == 2 );
                        exclArray = [ 1; 2; exclArray - 2; exclArray - 1; exclArray; exclArray + 1; exclArray + 2 ];
                        candArray = setdiff( find( trialArray(:, 1 ) == type ), exclArray );
                        
                        evtIdx = randsample( candArray, 1 );
                        
                        trialArray = trialArray( [ 1:evtIdx evtIdx evtIdx + 1:end ], : );
                        trialArray( evtIdx + 1, 2 ) = 2;
                        
                    end
                    
                case 4 % sinusoidal ascending
                    
                    trialArray = [];
                    trialArray = [ repmat( 12:-1:1, [ 1 55 ] ) 12:-1:3 ]';
                    trialArray( :, 2 ) = 1;
                    
                    typeArray = [ repmat( 1:11, [ 1 6 ] ) randsample( 1:11, 9 ) ];
                    typeArray = typeArray( randperm( length( typeArray ) ) );
                    
                    for iDev = 1:75
                        
                        type = typeArray( iDev );
                        exclArray = find( trialArray( :, 2 ) == 2 );
                        exclArray = [ 1; 2; exclArray - 2; exclArray - 1; exclArray; exclArray + 1; exclArray + 2 ];
                        candArray = setdiff( find( trialArray(:, 1 ) == type ), exclArray );
                        
                        evtIdx = randsample( candArray, 1 );
                        
                        trialArray = trialArray( [ 1:evtIdx evtIdx - 1 evtIdx evtIdx + 1:end ], : );
                        trialArray( evtIdx + 1, 2 ) = 2;
                        
                    end
                    
            end
            
            trialArray = [ ( 1:size( trialArray, 1 ) )' trialArray ];

            % Trigger
            trialArray( :, 4 ) = trialArray( :, 3 ) + condArray( iCond ) * 10;
            
            filename = sprintf( '%02d-%d-%d.txt', subjArray( iSubj ), condArray( iCond ), blockArray( iBlock ) );
            dlmwrite( fullfile( 'trialdef', filename ), trialArray, 'delimiter', '\t' )

            filename = sprintf( '%02d-%d-%d.txt', subjArray( iSubj ) + 20, condArray( iCond ), blockArray( iBlock ) );
            dlmwrite( fullfile( 'trialdef', filename ), trialArray, 'delimiter', '\t' )

        end
        
    end
    
end

end
