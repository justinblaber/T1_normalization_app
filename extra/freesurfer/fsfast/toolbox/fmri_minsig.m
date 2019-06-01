function [minsig, iminsig, indminsig] = fmri_minsig(sig)
% [minsig, iminsig, indminsig] = fmri_minsig(sig)
% 
% sig: - raw (-1,1) significance values (nrows X ncols X nplanes)
% minsig - (nrows X ncols), signed, bonferroni corrected
% iminsig - (nrows X ncols), plane index of minimum
% indminsig - iminsig indexed into sig.
%
%


%
% fmri_minsig.m
%
% Original Author: Doug Greve
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2011/03/02 00:04:06 $
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

if(nargin ~= 1)
  msg = '[minsig, iminsig, indminsig] = fmri_minsig(sig)'
  qoe(msg); error(msg);
end

szsig = size(sig);
nplanes = szsig(length(szsig))
szvox = szsig(1:length(szsig)-1)
nvox = prod(szvox)

sig = reshape(sig, [nvox nplanes])'; %' nplanes X nvox

% Get minimum along the plane dimension, 
% Use abs() so as not to get confused with sign.
% The sign will be recovered later.
[minsig iminsig] = min(abs(sig),[],1);

keyboard

% Bonferoni Correct and Reshape %
minsig = nplanes * reshape(sig(iminsig,:), szvox);
iminsig = reshape(iminsig, szvox);

return;

%% Go through some gymnastics to get the signed pmin %%
[nrows ncols nplanes] = size(sig);
xx = [1:nrows]' * ones(1,ncols); %'
I1 = reshape1d(xx);
I2 = reshape1d(xx'); %'

indminsig = sub2ind(size(pSig),I1,I2,reshape1d(iminsig));

minsig    = reshape(sig(indminsig), [nrows ncols]);      

% Bonferoni Correction
minsig = minsig * size(sig,3);  

return;
