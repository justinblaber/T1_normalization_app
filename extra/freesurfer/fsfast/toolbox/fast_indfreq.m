function indfreq = fast_indfreq(freq,Ntp,TR)
% indfreq = fast_indfreqfft(freq,Ntp,TR)
%
% Returns the index of the fft whose frequency
% is closest to freq.
%
%


%
% fast_indfreq.m
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

if(nargin ~= 3) 
  msg = 'USAGE: indfreq = indfreqfft(freq,Ntp,TR)';
  qoe(msg); error(msg);
end

freqaxis = fast_fftaxis(Ntp,TR);
[mm indfreq] = min(abs(freq-freqaxis);

return;
