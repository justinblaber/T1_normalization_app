function p = fast_z2p(z)
% p = fast_z2p(z)
% converts z values into p values (ie, the area under the curve 
% to the right of the z value). This is a one-tailed test (ie,
% the p-value does not take the sign of the z).
%
%


%
% fast_z2p.m
%
% Original Author: Doug Greve
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2011/03/02 00:04:05 $
%    $Revision: 1.5 $
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

p = erfc((z(:))/sqrt(2))/2;
p = reshape(p,size(z));

% Do this if you are signing the z
%p = p.*sign(z);
%ind = find(z==0);
%p(ind) = 1;

return;




