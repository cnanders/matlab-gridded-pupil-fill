% 

function [xOut, yOut, iOut] = getAnnular(r1, r2, numOfSamples)


% square sampling grid
x = linspace(-1, 1, numOfSamples);
y = linspace(-1, 1, numOfSamples);
[x, y] = meshgrid(x, y);

index = sqrt(x.^2 + y.^2) >= r1 & ...
        sqrt(x.^2 + y.^2) <= r2;

xOut = x(index);
yOut = y(index);
iOut = ones(size(xOut));













