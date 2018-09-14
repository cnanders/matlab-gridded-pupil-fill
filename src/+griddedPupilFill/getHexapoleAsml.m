function [xOut, yOut, iOut] = getHexapoleAsml(r, rotation, numOfSamples)

import griddedPupilFill.*

% square sampling grid
x = linspace(-1, 1, numOfSamples);
y = linspace(-1, 1, numOfSamples);
[x, y] = meshgrid(x, y);

xOut = [];
yOut = [];
iOut = [];


angles = [0, 60, 120, 180, 240, 300] + rotation;
deltaAngle = angles(2) - angles(1);

for n = 1 : length(angles)
    
    angle1 = angles(n) + deltaAngle / 2;
    angle2 = angles(n) - deltaAngle / 2;
    
    poles = [...
        struct( ...
           'x', 0, ...
           'y', 0, ...
           'r', 1 ...
        ), ... % pupil
        struct( ...
            'x', r * cos(angle1 * pi / 180), ...
            'y', r * sin(angle1 * pi / 180), ...
            'r', 1 ...
        ), ...
        struct( ...
            'x', r * cos(angle2 * pi / 180), ...
            'y', r * sin(angle2 * pi / 180), ...
            'r', 1 ...
        ) ...
    ];

    int = getLogicalAndOfCircles(x, y, poles);

    index = int > 0.01;

    xOut = [xOut x(index)'];
    yOut = [yOut y(index)'];
    iOut = [iOut int(index)'];

end









