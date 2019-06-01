function [a, vtemplate] = fmri_abjackknife(v,alist,blist)
% [a vtemplate] = fmri_abjackknife(v,alist,blist)
%
% size(v) = (Nh,Nvox,Nsamples)


%
% fmri_abjackknife.m
%
% Original Author: Doug Greve
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2011/03/02 00:04:05 $
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

if(nargin ~= 3)
  msg = 'USAGE: a = fmri_abjackknife(v,alist,blist)';
  qoe(msg);error(msg);
end

[Nh Nvox Nsamples] = size(v);

vtemplate  = fmri_norm(mean(v(:,:,blist),3),2);

n = 1;
for s = alist,

  if(size(v,1) > 1)
    a(n,:) = sum(v(:,:,s).*vtemplate);
  else
    a(n,:) = v(:,:,s).*vtemplate;
  end
  n = n + 1;
end

return;
