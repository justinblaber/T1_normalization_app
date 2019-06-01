function invLambda = fast_invlambda(ErrCovMtx,nEigen)
% invLambda = fast_invlambda(ErrCovMtx,nEigen)


%
% fast_invlambda.m
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

if(nargin ~= 2)
  msg = 'USAGE: invLambda = fast_invlambda(ErrCovMtx,nEigen)';
  qoe(msg);error(msg);
end

NormErrCovMtx = fast_normcovmtx(ErrCovMtx);

[u s v] = svd(NormErrCovMtx);

nn = [1:nEigen];
ds = diag(s);
ds2 = ds(nn);
ids = 1./ds2;
is = diag(ids);
invLambda = u(:,nn) * is * u(:,nn)'; %'

return;
