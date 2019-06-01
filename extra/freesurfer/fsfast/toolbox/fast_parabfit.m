function [par, yhat] = fast_parabfit(x,y)
% [par yhat] = fast_parabfit(x,y)
%
% Fit a parabola.
%
%  y = y0 + m*(x-x0).^2
%
%  Fits for parameters par = [y0 m x0]
%
%


%
% fast_parabfit.m
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

par = [];
yhat = [];

if(nargin ~= 2)
  fprintf('[par yhat] = fast_parabfit(x,y)\n');
  return;
end

% First, fist a linear model
x = reshape1d(x);
nx = length(x);
X = [ones(nx,1) x x.^2];
beta = inv(X'*X)*X'*y;
yhat = X*beta;

% Compute parameters from linear coefficients
m = beta(3);
x0 = -beta(2)/(2*m);
y0 = beta(1)-m*x0^2;
par = [y0 m x0];

return;






