function volformat = fast_getvolformat(volid)
% volformat = fast_getvolformat(volid)
% 
%


%
% fast_getvolformat.m
%
% Original Author: Doug Greve
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2011/03/02 00:04:04 $
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

volformat = [];

if(nargin ~= 1)
  msg = 'USAGE: volformat = fast_getvolformat(volid)'
  qoe(msg); error(msg);
end

if(fast_ismincvol(volid))  volformat = 'minc';
elseif(fast_isbvol(volid)) volformat = 'bfile';
end


return;
