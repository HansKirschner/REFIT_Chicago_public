function [O] = AGF_running_average(X, bef, post)
%Simply calculates a running average that squeezes at borders.
%If input is a matrix (not a vector), smoothing is performed for every row (along the x-axis).
%%
if min(size(X)) == 1 %vector input
    for c = 1 : length(X)
        %check distance from beginning
        if bef >= c
            ubef = 1;
        else
            ubef = c-bef;
        end;
        %check distance from end
        if length(X)-c < post
            upost = length(X);
        else
            upost = c + post;
        end;
        O(c) = nanmean(X(ubef:upost));
    end;
else %matrix input
    
    for c = 1 : size(X,2)
        %check distance from beginning
        if bef >= c
            ubef = 1;
        else
            ubef = c-bef;
        end;
        %check distance from end
        if length(X)-c < post
            upost = length(X);
        else
            upost = c + post;
        end;
        for y = 1 : size(X,1)
            O(y,c) = nanmean(X(y,ubef:upost));
        end;
    end;
end;