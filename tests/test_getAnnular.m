clear
clc
close all

cPath = fullfile('..', 'src');
addpath(cPath);
import griddedPupilFill.*

[xOut, yOut, iOut] = getAnnular(0.35, 0.55, 90);

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


[x, y, t] = getTimeSignals(xOut, yOut, iOut, 24e-6, 100e-3);

figure
subplot(131)
plot(t, x, '.-')
ylim([-1 1])
title('x(t)');
subplot(132)
plot(t, y, '.-')
ylim([-1 1])
title('y(t)');

subplot(133)
plot(x, y, 'o-')

title('x(t) vs. y(t)');
axis image
xlim([-1 1])
ylim([-1 1])






