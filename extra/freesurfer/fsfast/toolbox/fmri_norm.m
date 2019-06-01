function u = fmri_norm(v,order)
% u = fmri_norm(v, <order>)
% 
% normalizes the columns of v. order=2 by default.
%
% '$Id: fmri_norm.m,v 1.4 2011/03/02 00:04:06 nicks Exp $'


%
% fmri_norm.m
%
% Original Author: Doug Greve
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2011/03/02 00:04:06 $
%    $Revision: 1.4 $
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

if(nargin == 0)
  msg = 'USAGE: u = fmri_norm(v, <order>)';
  qoe(msg);error(msg);
end

if(size(v,1)==1)
  u = ones(size(v));
  return;
end

if(nargin == 1 ) order = 2 ; end

f = (sum(v.^order)).^(1/order);
ind = find(f==0);
f(ind) = 10^10;
u = v ./ repmat(f,[size(v,1) 1]);

return;
