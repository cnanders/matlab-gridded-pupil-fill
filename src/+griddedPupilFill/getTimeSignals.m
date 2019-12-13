% Returns x(t), y(t), and t given a set of x, y, intensity lists
% for pupil fill probe locations in -1, 1 and intensity is arbitrary.
% It sets it so the entire fill takes period seconds and the time samples
% are separate by dt
% @param {double 1xm} x - list of x values of each probed pupil position
% @param {double 1xm} y - list of y values of each probed pupil position
% @param {double 1xm} int - list of intensity values of each probed pupil position
% @param {double 1x1} dt - spacing of time samples
% @param {double 1x1} period - period of pupil fill
% @param {double 1x1} [velocityOfTransition = 800] - velocity of
% transitions in sigma per second that are added when there are jumps > sigma of 0.1

function [xOut, yOut, tOut] = getTimeSignals(...
    x, ...
    y, ...
    int, ...
    dt, ...
    period, ...
    velocityOfTransition ...
)

if nargin == 5
    velocityOfTransition = 800;
end

% intentensity is proportional to time so sum all intensity to get relative
% total time

intSum = sum(int);
timePerIntensity = period/intSum;
timeSamplesPerIntensity = timePerIntensity / dt;

% Generate a signal that is the 

xOut = [];
yOut = [];

% If the step between two points is larger than some value,
% add a transition

sigOfStepThatRequiresTransition = 0.1;
lDebug = true;

for n = 1 : length(int)
    samples = round(int(n) * timeSamplesPerIntensity);
    
    if (n > 1 && ...
        ~isempty(xOut) && ...
        ~isempty(yOut) > 0 ...
       )
        % Check for transition
        sigOfStep = sqrt((x(n) - xOut(end)).^2 + (y(n) - yOut(end)).^2);

        if sigOfStep >= sigOfStepThatRequiresTransition
            
            timeOfTransition = sigOfStep / velocityOfTransition;
            samplesOfTransition =  timeOfTransition / dt;
            xOut = [xOut linspace(xOut(end), x(n), samplesOfTransition)];
            yOut = [yOut linspace(yOut(end), y(n), samplesOfTransition)];
            
            lDebug & fprintf('getTimeSignals() creating a transition of %1.0f samples (%1.0f us) for jump of %1.2f sigma (> %1.1f sigma threshold)\n', ...
                samplesOfTransition, ...
                timeOfTransition * 1e6, ...
                sigOfStep, ...
                sigOfStepThatRequiresTransition ...
            );
        end
    end
    
    if samples > 0
        xOut = [xOut ones(1, samples) * x(n)];
        yOut = [yOut ones(1, samples) * y(n)];
    end
end


% Check for transition between end and beginning
sigOfStep = sqrt((xOut(1) - xOut(end)).^2 + (yOut(1) - yOut(end)).^2);

if sigOfStep >= sigOfStepThatRequiresTransition

    timeOfTransition = sigOfStep / velocityOfTransition;
    samplesOfTransition =  timeOfTransition / dt;
    xOut = [xOut linspace(xOut(end), xOut(1), samplesOfTransition)];
    yOut = [yOut linspace(yOut(end), yOut(1), samplesOfTransition)];

    lDebug & fprintf('getTimeSignals() creating a transition of %1.0f samples (%1.0f us) for jump of %1.2f sigma (> %1.1f sigma threshold)\n', ...
        samplesOfTransition, ...
        timeOfTransition * 1e6, ...
        sigOfStep, ...
        sigOfStepThatRequiresTransition ...
    );
end
        

tOut = [0 : dt: (length(xOut) - 1) * dt];



