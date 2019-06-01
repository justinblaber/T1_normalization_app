function pthresh = fast_fdrthresh(p,fdr)
% pthresh = fast_fdrthresh(p,fdr)
%
% p = list of p values between -1 and 1
% fdr = false discovery rate, between 0 and 1
%
% Based on Tom's FDR.m from 
%   http://www.sph.umich.edu/~nichols/FDR/FDR.m
% The threshold returned from this function is based on an 
% assumption of "independence or positive dependence",
% which should be "reasonable for imaging data".
%
%
%


%
% fast_fdrthresh.m
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

pthresh = [];

if(nargin ~= 2)
  fprintf('pthresh = fast_fdrthresh(p,fdr)\n');
  return;
end

p = sort(abs(p(:)));
Nv = length(p(:));
nn = [1:Nv]';

cVID = 1; % Not sure what this is for

imax = max( find(p <= fdr*nn/Nv ) );
if(~isempty(imax))
  %fprintf('imax = %d\n',imax);
  pthresh = p(imax);
else
  pthresh = min(p);
end

return;
