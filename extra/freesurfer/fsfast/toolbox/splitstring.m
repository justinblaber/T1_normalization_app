function split = splitstring(str)
%
% split = splitstring(str)
%
% Split a string into vertically concatenated strings.
%
%


%
% splitstring.m
%
% Original Author: Doug Greve
% CVS Revision Info:
%    $Author: nicks $
%    $Date: 2011/03/02 00:04:07 $
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
  msg = 'USAGE: split = splitstring(str)';
  qoe(msg);error(msg);
end

nstr = 1;
[split nscanned ] = sscanf(str,'%s',1);

while(nscanned > 0)
  fmt = repmat('%*s ',[1 nstr]);
  fmt = [fmt '%s'];
  [tmp nscanned] = sscanf(str,fmt,1);
  if(~isempty(tmp))
    split = strvcat(split,tmp);
    nstr = nstr + 1;
  end
end

return
