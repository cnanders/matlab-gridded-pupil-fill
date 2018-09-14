% 

function [xOut, yOut, iOut] = getQuadrupoleAsml(rho, rotation, numOfSamples)

import griddedPupilFill.*

% square sampling grid
x = linspace(-1, 1, numOfSamples);
y = linspace(-1, 1, numOfSamples);
[x, y] = meshgrid(x, y);

xOut = [];
yOut = [];
iOut = [];

angles = [0, 90, 180, 270] + rotation;

for n = 1 : length(angles)
    
    poles = [...
        struct( ...
           'x', 0, ...
           'y', 0, ...
           'r', 1 ...
        ), ... % pupil
        struct( ...
            'x', rho * cos(angles(n) * pi / 180), ...
            'y', rho * sin(angles(n) * pi / 180), ...
            'r', 1 ...
        ) ... % pole
    ];

    int = getLogicalAndOfCircles(x, y, poles);

    index = int > 0.01;

    xOut = [xOut x(index)'];
    yOut = [yOut y(index)'];
    iOut = [iOut int(index)'];

end



