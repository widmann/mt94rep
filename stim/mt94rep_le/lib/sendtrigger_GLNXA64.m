function sendtrigger_GLNXA64(val)
% Trigger device function for 64bit Linux
% Copyright (c) 2012 Andreas Widmann, University of Leipzig
% Author: Andreas Widmann, widmann@uni-leipzig.de

ppdev_mex('Write', 1, val);
% t = GetSecs;
% Eyelink('Message', sprintf('%d', val));
% WaitSecs('UntilTime', t + 0.001);
WaitSecs(0.004);
ppdev_mex('Write', 1, 0);

end

