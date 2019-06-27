% 

function [xOut, yOut, iOut] = getFromImage(numOfSamples)

import griddedPupilFill.*

[file,path] = uigetfile('*.jpg');

a = imread(fullfile(path, file));

% Resample image to the provided grid stolen from
% https://www.mathworks.com/help/matlab/math/resample-image-with-gridded-interpolation.html
F = griddedInterpolant(double(a));
[numX, numY, numZ] = size(a);
xq = (0:numX/numOfSamples:numX)';
yq = (0:numY/numOfSamples:numY)';
zq = (1:numZ)';

if length(zq) == 1
    vq = uint8(F({xq,yq}));
    a = double(vq);
else
    vq = uint8(F({xq,yq,zq}));
    a = double(rgb2gray(vq));
end



a = a./max(max(a));

% square sampling grid
x = linspace(-1, 1, numOfSamples);
y = linspace(-1, 1, numOfSamples);
[x, y] = meshgrid(x, y);


xOut = [];
yOut = [];
iOut = [];

for n = 1 : numOfSamples
    for m = 1 : numOfSamples
        xOut(end + 1) = x(n, m);
        yOut(end + 1) = y(n, m);
        iOut(end + 1) = a(n, m);
    end
end

indexLow = iOut < 0.05;
xOut(indexLow) = [];
yOut(indexLow) = [];
iOut(indexLow) = [];







