function [ data ] = all_read( logfile )
%%
% [data] = paris_read(logfile)
%
% reads presentation dat file produced by PARIS Task
%
% input
%  logfile	.. presentation logfile, required
%  logfile2 .. presentation logfile for final estimates at end of blocks (if present, not required)
%
% output
%  data    	..  structure containing infos for every trial with the following fields:

% read dat file
[filehandle, message] = fopen(logfile);
if filehandle == -1 
   error(message)
end
raw = {};
while ~feof(filehandle)
   raw = [raw; {fgetl(filehandle)}];
end
fclose(filehandle);
%%
for ln = 1:length(raw)
    ldata(ln).line = strread(raw{ln},'%s')';
end
% keyboard
%%
for c = 3 : length(ldata)
    for c2 = 1 : length(ldata(2).line)
        data.(ldata(2).line{c2})((c-1),1) = str2num(ldata(c).line{c2});
    end
end


%%
return;
