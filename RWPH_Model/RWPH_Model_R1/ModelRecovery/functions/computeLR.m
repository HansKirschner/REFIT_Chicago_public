function [LR, UP, PE]=computeLR(outcomes, predictions, newBlock)

%% find the last trial of each block
a=find(newBlock)-1;
a=a(a>0);

UP=nan(length(outcomes),1);    
UP(1:end-1)=predictions(2:end)-predictions(1:end-1);
PE=outcomes-predictions;
LR=UP./PE;

UP(a)=nan;
PE(a)=nan;
LR(a)=nan;

