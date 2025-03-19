function [pChoice choice]=softMax(values, invT)

%keyboard
values=values-(max(values));

pChoice=exp(values.*invT)./nansum(exp(values.*invT));

if nargout>1
    choice=find(cumsum(pChoice)>rand, 1);
end
