% @param {double 1x1} sigMax - the max sigma.  This assumes a "golden"
% ratio of sigma = 1.45 for the offset of the six poles relative to the
% sigMax value

function [xOut, yOut, iOut] = getHexapoleAsml(sigMax, rotation, numOfSamples)

import griddedPupilFill.*

% square sampling grid
x = linspace(-1, 1, numOfSamples);
y = linspace(-1, 1, numOfSamples);
[x, y] = meshgrid(x, y);


r = 1.45; % the magic ratio

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
           'r', sigMax ...
        ), ... % pupil
        struct( ...
            'x', sigMax * r * cos(angle1 * pi / 180), ...
            'y', sigMax * r * sin(angle1 * pi / 180), ...
            'r', sigMax ...
        ), ...
        struct( ...
            'x', sigMax * r * cos(angle2 * pi / 180), ...
            'y', sigMax * r * sin(angle2 * pi / 180), ...
            'r', sigMax ...
        ) ...
    ];

    int = getLogicalAndOfCircles(x, y, poles);

    index = int > 0.01;

    xOut = [xOut x(index)'];
    yOut = [yOut y(index)'];
    iOut = [iOut int(index)'];

end









