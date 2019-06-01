function [Mss, Rss] = fmri_subsampmat(TR,Ntp,TS)
% [Mss Rss] = fmri_subsampmat(TR,Ntp,TS)
%
% Creates a subsampling matrix


%
% fmri_subsampmat.m
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


if(nargin ~= 3)
  msg = 'USAGE: [Mss Rss] = fmri_subsampmat(TR,Ntp,TS)';
  qoe(msg);error(msg);
end

Rss = floor(TR/TS);
if(Rss < 1)
  msg = sprintf('Subsampling factor must be >= 1');
  qoe(msg);error(msg);
end

if(Rss == 1)
  Mss = eye(Ntp);
  return;
end

Nsp = Rss*Ntp;

Mss = zeros(Ntp,Nsp);
w   = [1:Rss:Nsp];
z   = [1:Ntp];
ind = sub2ind([Ntp Nsp], z,w);
Mss(ind) = 1;


return;
