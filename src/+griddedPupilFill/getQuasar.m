
function [xOut, yOut, iOut] = getQuasar(varargin)
    
%% Input Validation and Parsing

p = inputParser;

iseven = @(x) mod(x, 2) == 0;
isodd = @(x) mod(x, 2) ~= 0;

addParameter(p, 'radiusPoleInner', 0.5, @(x) isscalar(x) && isnumeric(x) && (x > 0) && (x <= 1))
addParameter(p, 'radiusPoleOuter', 0.7, @(x) isscalar(x) && isnumeric(x) && (x > 0) && (x <= 1))
addParameter(p, 'numPoles', 4, @(x) isscalar(x) && isinteger(x) && (x > 0))
addParameter(p, 'thetaPole', 30, @(x) isscalar(x) && isnumeric(x) && (x > 0))
addParameter(p, 'numOfSamples', 80, @(x) isscalar(x) && isnumeric(x) && (x > 0))

parse(p, varargin{:});

radiusPoleInner = p.Results.radiusPoleInner;
radiusPoleOuter = p.Results.radiusPoleOuter;
numPoles = double(p.Results.numPoles);
thetaPole = p.Results.thetaPole;
numOfSamples = p.Results.numOfSamples;
    
import griddedPupilFill.*

% square sampling grid
x = linspace(-1, 1, numOfSamples);
y = linspace(-1, 1, numOfSamples);
[x, y] = meshgrid(x, y);

[theta2, rho2] = cart2pol(x, y);
x = x(:);
y = y(:);
theta = theta2(:) * 180 / pi; % deg
rho = rho2(:);

% Anywhere theta is negative, add 360 to it

lNeg = theta < 0;
theta = theta + 360 * lNeg;

xOut = [];
yOut = [];
iOut = [];

thetaPoleSep = 360 / numPoles;
    
for n = 1 : numPoles % poles

    % Go counter clockwise
    theta_center = (n - 1) * thetaPoleSep;
    theta_start = theta_center - thetaPole / 2;
    theta_end = theta_center + thetaPole / 2;
    
    % make values in [0 360] for simplicity
    theta_start = mod(theta_start, 360);
    theta_end = mod(theta_end, 360);
    
    if (theta_start > theta_end)
        lTheta = (theta >= theta_start & theta <= 360) | (theta <= theta_end);
        lRho = rho >= radiusPoleInner & rho <= radiusPoleOuter;
        lBoth = lTheta & lRho;
    else 
        lTheta = theta >= theta_start & theta <= theta_end;
        lRho = rho >= radiusPoleInner & rho <= radiusPoleOuter;
        lBoth = lTheta & lRho;
    end
        
    xOut = [xOut x(lBoth)'];
    yOut = [yOut y(lBoth)'];
end

iOut = ones(size(xOut));






