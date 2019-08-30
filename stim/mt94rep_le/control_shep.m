function control_shep
% mt94rep - Wrapper function
% Copyright (c) 2019 Annika Werwach and Andreas Widmann, University of Leipzig
% Author: Annika Werwach and Andreas Widmann, widmann@uni-leipzig.de

subjArray = 1:40;
nSubj = length (subjArray);

condArray = 5:8;
nCond = 4;

for iSubj = 1:nSubj
    
    for iCond = 1:nCond
        switch condArray (iCond)
            case 5    %cond 5a = 1
                
                A = [12 1; 11 1; 11 2; 10 1; 9 1; 9 2; 8 1; 7 1; 7 2; 6 1; 5 1; 5 2; 4 1; 3 1; 3 2; 2 1; 1 1; 1 2];
                
                trialArray =  [ repmat( A , 37, 1);12 1; 11 1; 11 2; 10 1; 9 1; 9 2; 8 1; 7 1; 7 2];
                sum( trialArray( :, 2 ) == 2 )
                
                
            case 6 %cond 5b = 2
                
                A = [12 1; 11 1; 10 1; 10 2; 9 1; 8 1; 7 1; 7 2; 6 1; 5 1; 4 1; 4 2; 3 1; 2 1; 1 1; 1 2];
                
                trialArray =  [ repmat( A , 56, 1); 12 1; 11 1; 10 1; 10 2];
                sum( trialArray( :, 2 ) == 2 )

                
                
            case 7 %cond 6a = 3
                
                A = [12 2; 11 1; 10 1; 11 2; 10 1; 9 1; 10 2; 9 1; 8 1; 9 2; 8 1; 7 1; 8 2; 7 1; 6 1; 7 2; 6 1; 5 1; 6 2; 5 1; 4 1; 5 2; 4 1; 3 1; 4 2; 3 1; 2 1; 3 2; 2 1; 1 1; 2 2; 1 1; 12 1; 1 2; 12 1; 11 1];
                
                trialArray =  [ repmat( A, 18, 1); 12 2; 11 1; 10 1; 11 2; 10 1; 9 1; 10 2; 9 1; 8 1; 9 2; 8 1; 7 1; 8 2; 7 1; 6 1; 7 2; 6 1; 5 1; 6 2; 5 1; 4 1; 5 2; 4 1; 3 1; 4 2; 3 1; 2 1; 3 2];
                
                trialArray(1,2) = 1;
                sum( trialArray( :, 2 ) == 2 )

                
                
                
            case 8 %cond 6b = 4
                
                A = [12 2; 11 1; 10 1; 9 1; 10 2; 9 1; 8 1; 7 1; 8 2; 7 1; 6 1; 5 1; 6 2; 5 1; 4 1; 3 1; 4 2; 3 1; 2 1; 1 1; 2 2; 1 1; 12 1; 11 1];
                
                trialArray =  [ repmat( A, 37, 1); 12 2; 11 1; 10 1; 9 1; 10 2; 9 1; 8 1; 7 1; 8 2; 7 1; 6 1; 5 1; 6 2];
                
                trialArray(1,2) = 1;
                sum( trialArray( :, 2 ) == 2 )
                
        end
        
         trialArray = [ ( 1:size( trialArray, 1 ) )' trialArray ];

            % Trigger
            trialArray( :, 4 ) = trialArray( :, 3 ) + condArray( iCond ) * 10;
            
            filename = sprintf( '%02d-%d-1.txt', subjArray( iSubj ), condArray( iCond ) );
            dlmwrite( fullfile( 'trialdef', filename ), trialArray, 'delimiter', '\t' )
    end
    
end


