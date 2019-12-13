% 

function [xOut, yOut, iOut] = reorderToMinimizeDeltas(xIn, yIn, iIn)

lTravelingSalesman = true;

if lTravelingSalesman
    positions(:, 1) = xIn;
    positions(:, 2) = yIn;

    [idxTour, lengthTour] = tsp(positions);

    xOut = xIn(idxTour);
    yOut = yIn(idxTour);
    iOut = iIn(idxTour);


    return
end

%}

xOut = xIn(1);
yOut = yIn(1);
iOut = iIn(1);


xIn(1) = [];
yIn(1) = [];
iIn(1) = [];

while length(iIn) > 0
    
    % Create vector [x, y] for all next possible points to last point
    vectors = [xIn' - xOut(end) yIn' - yOut(end)];
    
    distances = sqrt(vectors(:,1).^2 + vectors(:,2).^2);
    
    % Also want to minimize changes in direction so if there are
    % multiple close points, take the one that changes direction the least.
    % The way to do this is to look at the vector of the previous two
    % points and then compare the new possible vectors with it via dot
    % product
    % Only need to do this if there are two points in xOut
    
    if length(xOut) >=2
        vectorPrev = [xOut(end) - xOut(end - 1) yOut(end) - yOut(end - 1)];
        
        normOfVectorPrev = norm(vectorPrev);
        
        % make a bunch of copies of it for the dot product
        vectorPrev = repmat(vectorPrev, length(xIn), 1);
        dotProducts = dot(vectorPrev, vectors, 2);
        
        
        angleCos = abs(dotProducts ./ distances ./ normOfVectorPrev);
        angleOfDirectionChange = real(acos(angleCos)) * 180 / pi;
        
        % angle change is between 0 and 180.  Need to divide by 180, then 
        % scale by the minimum of discances and add to distance before
        % sorting
        
        distances = distances + angleOfDirectionChange / 180 * min(distances) * 0.5 ;
        
        
    end
    
    % Reorder distances, xIn, yIn, iIn by same order
    
    [distancesSorted, index] = sort(distances);
    
    % Push first element of sorted list to output lists
    xOut(end + 1) = xIn(index(1));
    yOut(end + 1) = yIn(index(1));
    iOut(end + 1) = iIn(index(1));
    
    % Remove from list of possibilities
    
    xIn(index(1)) = [];
    yIn(index(1)) = [];
    iIn(index(1)) = [];
    
end

    
    
    
    













