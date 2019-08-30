function ptbcleanup
% Psychtoolbox generic cleanup function
% Copyright (c) 2012 Andreas Widmann, University of Leipzig
% Author: Andreas Widmann, widmann@uni-leipzig.de
    
% Deinit parallel port
try
    ppdev_mex('Close', 1);
catch
end

PsychPortAudio('Close')

end

