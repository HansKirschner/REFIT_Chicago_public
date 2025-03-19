function o = AGF_round2decimals( s, n )
%a function that rounds all entries in a vector or array to n decimals.
o = round((10^n)*s)./(10^n);
return;