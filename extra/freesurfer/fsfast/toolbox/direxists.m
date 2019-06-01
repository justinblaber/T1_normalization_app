function r = direxists(dirpath)
% r = direxists(dirpath)
%
% returns 1 if dirpath exists, 0 else
%
%


%
% direxists.m
%
% Original Author: Doug Greve
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2011/03/02 00:04:03 $
%    $Revision: 1.3 $
%
% Copyright © 2011 The General Hospital Corporation (Boston, MA) "MGH"
%
% Terms and conditions for use, reproduction, distribution and contribution
% are found in the 'FreeSurfer Software License Agreement' contained
% in the file 'LICENSE' found in the FreeSurfer distribution, and here:
%
% https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSoftwareLicense
%
% Reporting: freesurfer@nmr.mgh.harvard.edu
%

r = -1;
if(nargin ~= 1)
  fprintf('r = direxists(dirpath)\n');
  return;
end

d = dir(dirpath);
if(size(d,1) == 0) r = 0;
else               r = 1;
end

return;





