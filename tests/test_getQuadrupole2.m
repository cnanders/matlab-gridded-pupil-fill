clear
clc
close all

cPath = fullfile('..', 'src');
addpath(cPath);
import griddedPupilFill.*


% [xOut, yOut, iOut] = getQuadrupole2();

[xOut, yOut, iOut] = getQuadrupole2(...
    'rotation', 45, ...
    'sigmaOfInnerStop', 0.4, ...
    'sigmaOfOuterStop', 0.9, ...
    'sigmaOfCenterOfOuterRings', 1.06, ...
    'sigmaOfOuterRings', 0.93 ...
); 


[xOut, yOut, iOut] = getQuadrupole2(...
    'rotation', 45, ...
    'sigmaOfInnerStop', 0.3, ...
    'sigmaOfOuterStop', 0.95, ...
    'sigmaOfCenterOfOuterRings', 1.06, ...
    'sigmaOfOuterRings', 0.93 ...
);

figure
hAxis1 = subplot(131);
plot(hAxis1, xOut, '.-')
ylim([-1 1])
hAxis2 = subplot(132);
plot(hAxis2, yOut, '.-')
ylim([-1 1])
hAxis3 = subplot(133);
plot(hAxis3, iOut, '.-')
axis(hAxis3, 'image');


figure
plot(xOut, yOut, 'o-')
title('scan path')
xlim([-1 1])
ylim([-1 1])


[x, y, t] = getTimeSignals(xOut, yOut, iOut, 24e-6, 100e-3);

figure
hAxis1 = subplot(131);
plot(hAxis1, t, x, '.-')
ylim(hAxis1, [-1 1])

hAxis2 = subplot(132);
plot(hAxis2, t, y, '.-')
ylim(hAxis2, [-1 1])

hAxis3 = subplot(133);
plot(hAxis3, x, y, 'o-')
axis(hAxis3, 'image')
xlim(hAxis3, [-1 1])
ylim(hAxis3, [-1 1])






