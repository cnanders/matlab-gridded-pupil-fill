function [xOut, yOut, iOut] = getDipole2(varargin)

%% Input Validation and Parsing

p = inputParser;

iseven = @(x) mod(x, 2) == 0;
isodd = @(x) mod(x, 2) ~= 0;

% sigma of the central stop
addParameter(p, 'sigmaOfOuterStop', 0.9, @(x) isscalar(x) && isnumeric(x) && (x > 0) && (x <= 1))
% sigma of the ring on which the six outer rings are centered.  
addParameter(p, 'sigmaOfCenterOfOuterRings', 1.17, @(x) isscalar(x) && isnumeric(x) && (x > 0) && (x <= 2))
% sigma of each outer ring
addParameter(p, 'sigmaOfOuterRings', 0.75, @(x) isscalar(x) && isnumeric(x) && (x > 0) && (x <= 1))
% global rotation
addParameter(p, 'rotation', 45, @(x) isscalar(x) && isnumeric(x) && (x >= 0))
% samples in pupil (1D)
addParameter(p, 'numOfSamples', 80, @(x) isscalar(x) && isnumeric(x) && (x > 0))

parse(p, varargin{:});

sigmaOfOuterStop = p.Results.sigmaOfOuterStop;
sigmaOfCenterOfOuterRings = p.Results.sigmaOfCenterOfOuterRings;
sigmaOfOuterRings = p.Results.sigmaOfOuterRings;
rotation = p.Results.rotation;
numOfSamples = p.Results.numOfSamples;


import griddedPupilFill.*

% square sampling grid
x = linspace(-1, 1, numOfSamples);
y = linspace(-1, 1, numOfSamples);
[x, y] = meshgrid(x, y);

xOut = [];
yOut = [];
iOut = [];

angles = [0, 180] + rotation;

for n = 1 : length(angles)
    
    angle = angles(n);
    
    poles = [...
        struct( ...
           'x', 0, ...
           'y', 0, ...
           'r', sigmaOfOuterStop ...
        ), ... % inner stop
        struct( ...
            'x', sigmaOfCenterOfOuterRings * cos(angle * pi / 180), ...
            'y', sigmaOfCenterOfOuterRings * sin(angle * pi / 180), ...
            'r', sigmaOfOuterRings ...
        )...
    ];

    int = getLogicalAndOfCircles(x, y, poles);

    indexAboveThreshold = int > 0.01; % only keep values above threshold
    % indexOutsideInnerStop = sqrt(x.^2 + y.^2) >= sigmaOfInnerStop; % mask with inner stop
    index = indexAboveThreshold; % & indexOutsideInnerStop;

    xOut = [xOut x(index)'];
    yOut = [yOut y(index)'];
    iOut = [iOut int(index)'];

end









