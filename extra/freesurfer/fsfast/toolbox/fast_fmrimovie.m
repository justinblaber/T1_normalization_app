function fmrimovie = fast_fmrimovie(f)
% fmrimovie = fast_fmrimovie(f)
%


%
% fast_fmrimovie.m
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

if(nargin ~= 1)
  msg = 'USAGE: fmrimovie = fast_fmrimovie(f)';
  qoe(msg);error(msg);
end

figure;
imagesc(f(:,:,1));
axis image;
set(gca,'nextplot','replacechildren');

%f = diff(f,[],3);

% Adjust the scale to 1 - 64 %
fmax = max(reshape1d(f));
fmin = min(reshape1d(f));

f = 64*(f-fmin)/(fmax-fmin) + 1;

colormap(gray);

for j = 1:size(f,3);
  image(f(:,:,j));
  %colorbar;
  h = text(10,10,num2str(j));
  set(h,'color',[1 1 1])
  set(h,'fontsize',15)
  fmrimovie(j)=getframe;
end  

close

return
