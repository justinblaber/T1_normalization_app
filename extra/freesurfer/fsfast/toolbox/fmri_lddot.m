function dot = fmri_lddot(dotfile)
% dot = fmri_lddot(dotfile)


%
% fmri_lddot.m
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
  msg = 'USAGE: dot = fmri_lddot(dotfile)';
  qoe(msg);error(msg);
end

dot = load(dotfile);
[n1 n2] = size(dot);
ntp = n1/2;
nsensors = n2;

dot = reshape(dot, [ntp 2 nsensors]);
dot = permute(dot, [2 3 1]);

return;

