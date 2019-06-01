function [sig, gmn, gmnvar, t, dof, p] = fast_ffx_osgm(means,varmeans,dofs,fdim)
% [sig gmn gmnvar t dof p] = fast_ffx_osgm(means,varmeans,dofs,<fdim>)
% 
% Simple one-sample-group-mean fixed effects analysis.
%   gmn    = mean(means)
%   gmnvar = mean(varmeans)/nsamples
%   t = gmn/sqrt(gmnvar)
%   dof = sum(dofs) [if dofs is a scalar, then dof = nsamples*dofs]
%   sig = -log10(p).*sign(gmn)
% The sample dimension (fdim) is assumed to be:
%   1. The first dim, if means is a matrix
%   2. The last dim is means has a dim > 2
%
% $Id: fast_ffx_osgm.m,v 1.3 2011/03/02 00:04:04 nicks Exp $

% To test FPR
% dofs = 100;
% nsamples = 20;
% y = randn(nsamples,10000,dofs);
% means = mean(y,3);
% varmeans = var(y,[],3)/dofs;
% [sig gmn gmnvar t dof p] = fast_ffx_osgm(means,varmeans,dofs);
% [pdf alpha nxhist fpr] = ComputePDF(p,.01,1,.01);
% plot(alpha,fpr,alpha,alpha)


%
% fast_ffx_osgm.m
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



if(nargin ~= 3 & nargin ~= 4)
  fprintf('[sig gmn gmnvar t dof p] = fast_ffx_osgm(means,varmeans,dofs,<fdim>)\n');
  return;
end

mdim = size(means);

% If fdim is not specified, try to figure out what it should be
% If the input is a 2D matrix, then assume that fdim=1,
% Else assume that fdim is the last dim
if(~exist('fdim','var')) fdim = []; end
if(isempty(fdim))
  if(length(mdim) == 2)  fdim = 1;
  else                   fdim = length(mdim);
  end
end

nframes = mdim(fdim);

ndofs = length(dofs);
if(ndofs == 1) dof = dofs*nframes;
else 
  if(ndofs ~= nframes)
    fprintf('ERROR: dimension mismatch dofs and frames\n');
    return;
  end
  dof = sum(dofs); 
end

gmn    = mean(means,fdim);
gmnvar = mean(varmeans,fdim)/nframes;

ind = find(gmn==0);
gmnvar(ind) = 1e10;

t = gmn./sqrt(gmnvar);

gmnvar(ind) = 0;
t(ind) = 0;

p = tTest(dof,t);
sig = -log10(p).*sign(gmn);

return;

