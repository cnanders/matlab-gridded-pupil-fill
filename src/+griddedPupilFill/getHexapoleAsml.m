function [xOut, yOut, iOut] = getHexapoleAsml(varargin)

%% Input Validation and Parsing

p = inputParser;

iseven = @(x) mod(x, 2) == 0;
isodd = @(x) mod(x, 2) ~= 0;

% sigma of the main ring
addParameter(p, 'sigmaOfCenterRing', 1, @(x) isscalar(x) && isnumeric(x) && (x > 0) && (x <= 1))
% sigma of the ring on which the six outer rings are centered.  
addParameter(p, 'sigmaOfCenterOfOuterRings', 1.17, @(x) isscalar(x) && isnumeric(x) && (x > 0) && (x <= 2))
% sigma of each outer ring
addParameter(p, 'sigmaOfOuterRings', 0.75, @(x) isscalar(x) && isnumeric(x) && (x > 0) && (x <= 1))
% global rotation
addParameter(p, 'rotation', 0, @(x) isscalar(x) && isnumeric(x) && (x >= 0))
% samples in pupil (1D)
addParameter(p, 'numOfSamples', 80, @(x) isscalar(x) && isnumeric(x) && (x > 0))

parse(p, varargin{:});

sigmaOfCenterRing = p.Results.sigmaOfCenterRing;
sigmaOfCenterOfOuterRings = p.Results.sigmaOfCenterOfOuterRings;
sigmaOfOuterRings = p.Results.sigmaOfOuterRings;
rotation = p.Results.rotation;
numOfSamples = p.Results.numOfSamples;


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
           'r', sigmaOfCenterRing ...
        ), ... % center ring
        struct( ...
            'x', sigmaOfCenterOfOuterRings * cos(angle1 * pi / 180), ...
            'y', sigmaOfCenterOfOuterRings * sin(angle1 * pi / 180), ...
            'r', sigmaOfOuterRings ...
        ), ...
        struct( ...
            'x', sigmaOfCenterOfOuterRings * cos(angle2 * pi / 180), ...
            'y', sigmaOfCenterOfOuterRings * sin(angle2 * pi / 180), ...
            'r', sigmaOfOuterRings ...
        ) ...
    ];

    int = getLogicalAndOfCircles(x, y, poles);

    index = int > 0.01;

    xOut = [xOut x(index)'];
    yOut = [yOut y(index)'];
    iOut = [iOut int(index)'];

end









