function y = se(x,varargin)
%just calculates the standard error of an observation using df of n - 1.
%if varargin is specified, a confidence interval (e.g., 0.95) can be
%provided, which will scale the se accordingly. If varargin == 0, wil
%return std.
%%
if ~isempty(varargin)
    if varargin{1}==0
        y = nanstd(x);
        return
    else
        y = nanstd(x) ./ sqrt(length(x)-1);
        if varargin{1}~=1
            confi = norminv(1+(0.5-(1-varargin{1}/2)),0,1);
            y = y * confi;
        end
    end
else
    y = nanstd(x) ./ sqrt(length(x)-1);
end