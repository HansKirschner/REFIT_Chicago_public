function [x,y,dataR,IQR] = violinplotHK(data)

n = size(data,1);
% get data distribution based on histogram
[y,x] = histcounts(data,'BinMethod','fd');
x = (x(1:end-1)+x(2:end))/2';
y = y./max(y);
% inter-quartile range
dataR = tiedrank(data)./n;
IQR = data([dsearchn(dataR,.25) dsearchn(dataR,.75)]);

end