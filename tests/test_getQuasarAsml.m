clear
clc
close all

cPath = fullfile('..', 'src');
addpath(cPath);
import griddedPupilFill.*

[xOut, yOut, iOut] = getQuasarAsml(1.1, 1.6, 0, 500);

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








