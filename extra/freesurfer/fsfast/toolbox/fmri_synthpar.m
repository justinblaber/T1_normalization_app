function Par = fmri_synthpar(nStimPerCond, TR, nRuns)
%
% Par = fmri_synthpar(nStimPerCond, TR, nRuns)
%
%
%
%


%
% fmri_synthpar.m
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

if(nargin ~= 2 & nargin ~= 3)
  msg = 'USAGE: Par = fmri_synthpar(nStimPerCond, TR, <nRuns>)';
  qoe(msg);error(msg);
end

if(nargin == 2) nRuns = 1; end

nCond = length(nStimPerCond);
nTP   = sum(nStimPerCond);

for r = 1:nRuns
  StimSeq = StimSessionSeq(nStimPerCond, 1);
  Par(:,:,r) = [TR*[0:(nTP-1)]' StimSeq ];
end

return


