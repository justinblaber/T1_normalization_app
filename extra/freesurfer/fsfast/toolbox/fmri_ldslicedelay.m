function [slc, slcdel] = fmri_ldslicedelay(fname)
% [slc slcdel] = 


%
% fmri_ldslicedelay.m
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
  msg = 'USAGE: [slc slcdel] = fmri_ldslicedelay(fname)';
  qoe(msg);error(msg);
end

fname = deblank(fname);

fid = fopen(fname,'r');
if(fid == -1)
  msg = sprintf('Could not open %s',fname);
  qoe(msg);error(msg);
end

tmp = fscanf(fid,'%f');
fclose(fid);

nslices = length(tmp)/2;
tmp = reshape(tmp, [2 nslices])'; %'
slc    = tmp(:,1);
slcdel = tmp(:,2);

%% resort by slice number %%
[y i] = sort(slc);
slc    = y;
slcdel = slcdel(i);

return;
