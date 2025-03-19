function [x,i]=nanrem(x)
% NANREM(X) 
% Removes nan values in the vector or array. If x is an array, removes all rows where one entry is nan.
%Also returns index of the rows where nans were found (= i)
%%
if istable(x)
    TF = ismissing(x,{NaN});
    x(any(TF,2),:)=[];
    i = find(any(TF,2));
else
    if min(size(x))==1
        i = find(isnan(x));
        x(isnan(x))=[];
    elseif length(size(x))==2
        if size(x,1) < size(x,2)
            disp('Warning: More columns than rows? Is that correct?')
        end;
        i=find(any(isnan(x),2));
        x=x(~any(isnan(x),2),:);
    else
        disp('Error: nanrem does not support multidimensional arrays.')
    end;
end;