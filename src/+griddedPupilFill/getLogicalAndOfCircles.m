% Returns an intensity map of the intersection of the provided circle
% definitions on the provided meshgrid.  Think of it like the overlap 
% region in the center of a venn-diagram or the logical and operation
% @param {double nxm} x - matrix of x values created by meshgrid
% @param {double nxm} y - matrix of y values created by meshgrid
% @param {struct 1x?} circles - list of structrures of circle definitions
% @param {double 1x1} circles[].x - x center of circle
% @param {double 1x1} circles[].y - y center of circle
% @param {double 1x1} circles[].radius - radius of circle


function out = getLogicalAndOfCircles(x, y, circles)
    
    if isempty(circles)
        out = zeros(size(x));
        return
    end

    % Build up a matrix for each circle
    
    out = ones(size(x));
    
    % For each circle, build a matrix of ones where it is located and
    % and it with the original 
    for n = 1 : length(circles)
        
        int = zeros(size(x));
        index = sqrt((x - circles(n).x).^2 + (y - circles(n).y).^2) < circles(n).r;
        int(index) = 1;
        out = out & int;
        
    end
    
end








