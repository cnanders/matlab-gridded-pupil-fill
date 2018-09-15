clear
clc
close all

[cDirThis, cName, cExt] = fileparts(mfilename('fullpath'));
cPath = fullfile(cDirThis, '..', 'src');
addpath(cPath);
import griddedPupilFill.*

% x = [3 10 1 10 3 1 9 8 3];
% y = [7 8 4 9.2 4 2 10 7 2];
% i = [1 2 3 4 5 6 7 8 9];
% 
% figure
% plot(x, y, 'o-');
% 
% 
% [xOut, yOut, iOut] = reorderToMinimizeDeltas(x, y, i);
% 
% figure
% plot(xOut, yOut, 'o-')
% title('scan path')

[xOut, yOut, iOut] = getDipoleAsml(1.7, 0, 80);

figure
subplot(131)
plot(xOut, '.-')
ylim([-1 1])
subplot(132)
plot(yOut, '.-')
ylim([-1 1])
subplot(133)
plot(xOut, yOut, 'o-')
title('scan path')
xlim([-1 1])
ylim([-1 1])

% Randomly re-arrange to make reordering as hard as possible
index = randperm(length(xOut));

figure('Name', 'Random arrangement sent to reorder function');
plot(xOut(index), yOut(index), 'o-')
xlim([-1 1])
ylim([-1 1])


[xOut, yOut, iOut] = reorderToMinimizeDeltas(...
    xOut(index), ...
    yOut(index), ...
    iOut(index) ...
);

figure('Name', 'Reordering of randomized arrangement')
subplot(131)
plot(xOut, '.-')
ylim([-1 1])
subplot(132)
plot(yOut, '.-')
ylim([-1 1])
subplot(133)
plot(xOut, yOut, 'o-')
xlim([-1 1])
ylim([-1 1])


figure('Name', 'Reordering of randomized arrangement')
plot3(xOut, yOut, [1 : length(yOut)], '.-')
xlim([-1 1])
ylim([-1 1])



[x, y, t] = getTimeSignals(xOut, yOut, iOut, 24e-6, 300e-3);

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
axis image
xlim([-1 1])
ylim([-1 1])
title('x(t) vs. y(t)');






%%



[xOut, yOut, iOut] = getAnnular(0.35, 0.6, 30);

figure
subplot(131)
plot(xOut, '.-')
ylim([-1 1])
subplot(132)
plot(yOut, '.-')
ylim([-1 1])
subplot(133)
plot(xOut, yOut, 'o-')
title('scan path')
xlim([-1 1])
ylim([-1 1])

% Randomly re-arrange to make reordering as hard as possible
index = randperm(length(xOut));

figure('Name', 'Random arrangement sent to reorder function');
plot(xOut(index), yOut(index), 'o-')
xlim([-1 1])
ylim([-1 1])


[xOut, yOut, iOut] = reorderToMinimizeDeltas(...
    xOut(index), ...
    yOut(index), ...
    iOut(index) ...
);

figure('Name', 'Reordering of randomized arrangement')
subplot(131)
plot(xOut, '.-')
ylim([-1 1])
subplot(132)
plot(yOut, '.-')
ylim([-1 1])
subplot(133)
plot(xOut, yOut, 'o-')
xlim([-1 1])
ylim([-1 1])


figure('Name', 'Reordering of randomized arrangement')
plot3(xOut, yOut, [1 : length(yOut)], '.-')
xlim([-1 1])
ylim([-1 1])




