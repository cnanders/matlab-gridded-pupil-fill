% Returns x(t), y(t), and t given a set of x, y, intensity lists
% for pupil fill probe locations in -1, 1 and intensity is arbitrary.
% It sets it so the entire fill takes period seconds and the time samples
% are separate by dt

function [xOut, yOut, tOut] = getTimeSignals(x, y, int, dt, period)


% intentensity is proportional to time so sum all intensity to get relative
% total time

intSum = sum(int);
timePerIntensity = period/intSum;
timeSamplesPerIntensity = timePerIntensity / dt;

% Generate a signal that is the 

xOut = [];
yOut = [];

for n = 1 : length(int)
    samples = round(int(n) * timeSamplesPerIntensity);
    xOut = [xOut ones(1, samples) * x(n)];
    yOut = [yOut ones(1, samples) * y(n)];
end

tOut = [0 : dt: (length(xOut) - 1) * dt];



