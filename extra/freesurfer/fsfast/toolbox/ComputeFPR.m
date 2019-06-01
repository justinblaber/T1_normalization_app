function [FPR, alpha] = ComputeFPR(p, pDelta)
%
% [FPR alpha] = ComputeFPR(p, <pDelta>)
%


%
% ComputeFPR.m
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

if(nargin == 1)  pDelta = .01; end

pRange = [(min(p)+pDelta/2) pDelta  (max(p)-pDelta/2)];
[pDist0 alpha pDelta0] = samp2pdf(p,pRange);

FPR = cumtrapz(alpha,pDist0);
FPR = FPR + alpha(1);

return;
