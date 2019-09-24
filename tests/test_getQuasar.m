clear
clc
close all

cPath = fullfile('..', 'src');
addpath(cPath);
import griddedPupilFill.*


[xOut, yOut, iOut] = getQuasar('radiusPoleOuter', 0.9, 'numPoles', uint8(6));

figure
subplot(131)
plot(xOut, '.-')
ylim([-1 1])
subplot(132)
plot(yOut, '.-')
ylim([-1 1])
subplot(133)
plot(iOut, '.-')


figure
plot(xOut, yOut, 'o-')
title('scan path')
xlim([-1 1])
ylim([-1 1])

velocityOfTransition = 2000; % units?
[x, y, t] = getTimeSignals(xOut, yOut, iOut, 24e-6, 50e-3, velocityOfTransition);

figure
subplot(131)
plot(t, x, '.-')
ylim([-1 1])
subplot(132)
plot(t, y, '.-')
ylim([-1 1])
subplot(133)
plot(x, y, 'o-')
xlim([-1 1])
ylim([-1 1])







