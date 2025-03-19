function x=normaliseT(x,S)

% normaliseT(X) 
% Removes the Average or mean value and makes the std=1 for a table. 
% If S = 0 (default: 1), will also scale columns with regressors with only 
% two values (i.e., categorial regressors).

if(nargin==1),
   S = 1;
end;
%%
FN=fieldnames(x);
for c = 1 : length(FN)-1
    if size(unique(x.(FN{c})),1) > 2 %only if more than two values are present
        x.(FN{c}) = x.(FN{c}) - nanmean(x.(FN{c}));
        x.(FN{c}) = x.(FN{c}) ./ nanstd(x.(FN{c}));
    end;
end;