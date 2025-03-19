function s = str_parsezero( s, nz )
%Little function that adds zeros until string length nz is reached and returns a string.
%AGF, 2018
%%
if ~isstr(s)
    s = num2str(s);
end

while length(s) < nz
    s = ['0' s];
end
return


