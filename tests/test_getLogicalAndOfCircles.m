clear
clc
close all

cPath = fullfile('..', 'src');
addpath(cPath);
import griddedPupilFill.*

% square sampling grid
numOfSamples = 100;
x = linspace(-1, 1, numOfSamples);
y = linspace(-1, 1, numOfSamples);
[x, y] = meshgrid(x, y);


poles = [...
    struct( ...
       'x', 0, ...
       'y', 0, ...
       'r', 1 ...
    ) ...
];

int = getLogicalAndOfCircles(x, y, poles);

figure
imagesc(int)
axis image
title('test case')

pole1 = struct( ...
   'x', 0, ...
   'y', 0, ...
   'r', 1 ...
);
pole2 = struct( ...
    'x', 1, ...
    'y', 0, ...
    'r', 1 ...
);
poles = [pole1, pole2];

int = getLogicalAndOfCircles(x, y, poles);

figure
imagesc(int)
axis image


pole1 = struct( ...
   'x', 0, ...
   'y', 0, ...
   'r', 1 ...
);
pole2 = struct( ...
    'x', 1.6, ...
    'y', 0, ...
    'r', 1 ...
);
poles = [pole1, pole2];

int = getLogicalAndOfCircles(x, y, poles);

figure
imagesc(int)
axis image


pole1 = struct( ...
   'x', 0, ...
   'y', 0, ...
   'r', 1 ...
);
pole2 = struct( ...
    'x', 1.1, ...
    'y', 1.1, ...
    'r', 1 ...
);
poles = [pole1, pole2];

int = getLogicalAndOfCircles(x, y, poles);

figure
imagesc(int)
axis image
title('dipole pole')

% Quasar pole

poles = [...
    struct( ...
       'x', 0, ...
       'y', 0, ...
       'r', 1 ...
    ), ...
    struct( ...
        'x', .1, ...
        'y', 1, ...
        'r', 1 ...
    ), ...
    struct( ...
        'x', 1, ...
        'y', .1, ...
        'r', 1 ...
    ), ...
    struct( ...
        'x', 1.1, ...
        'y', 1.1, ...
        'r', 1 ...
    ) ...
];

int = getLogicalAndOfCircles(x, y, poles);

figure
imagesc(int)
axis image
title('quasar pole')



