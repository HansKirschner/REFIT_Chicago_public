function s = AGF_prune_string( s, n )
%a function that shortens a cell array of strings to equal length n each. 
%also replaces '_' with spaces.
%%
for c = 1 : length(s)
    if ~isempty(n) && length(s{c})>n
        s{c} = s{c}(1:n);
    end;
    s{c} = strrep(s{c}, '_', ' ');
end;
return;