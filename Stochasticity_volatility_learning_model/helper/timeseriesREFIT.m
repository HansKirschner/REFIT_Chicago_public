function [y,x]=timeseriesREFIT(config)

%keyboard 

% omega = 0.01;
% x = config.out_cometask;
% y = x + sqrt(omega)*randn(size(x));

change_points = find(diff(config.p_task)~=0)+1;

totalStuff = ones(length(change_points)+1,1);
totalStuff(2:end) = change_points;

m = config.p_task(totalStuff);
omega = nan(length(totalStuff),1);
omega(m==.5)= .05;
omega(m==.3)= .03;
omega(m==.7)= .03;
omega(m==.2)= .01;
omega(m==.8)= .01;

N = length(config.p_task);

x = nan(N,1);
y = nan(N,1);

for i = 1:length(totalStuff)-1

     ii = totalStuff(i):totalStuff(i+1)-1;

     x(ii) = m(i)*ones(length(ii),1);
     y(ii) = x(ii) + sqrt(omega(i))*randn(length(ii),1);

end

ii = totalStuff(end):N;
x(ii) = m(end)*ones(length(ii),1);
y(ii) = x(ii) + sqrt(omega(end))*randn(length(ii),1);

