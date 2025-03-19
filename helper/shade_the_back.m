function [] = shade_the_back(x, c, i)
%function that shades the background of a figure.
%input: x = logic vector of x values where a shade should be (e.g., [0 0 1 1 1 0 0 1 1 0 ])
%c = color
%i = index of x axis values, e.g., time that is plotted
%%
a = gca; bc = 1; BoxOpen = 0;
AllY = [a.YLim(1) a.YLim(2) a.YLim(2) a.YLim(1)];
for xc = 1 : length(x)
    if x(xc) == 1 & BoxOpen == 0 %begin a new box
        BoxOpen = 1;
        AllX(bc,1:2) = [i(xc) i(xc)];
    elseif (x(xc) == 0 & BoxOpen == 1) | (xc == length(x) & BoxOpen == 1) %and box and plot it
        BoxOpen = 0;
        AllX(bc,3:4) = [i(xc) i(xc)];
        %plot the patch --> alpha can be adjusted manually, shade should not have an edge
        patchh = patch(AllX(bc,:),AllY,c,'FaceAlpha',0.2,'EdgeColor', 'none');
        %put it to the background
        uistack(patchh,'bottom'); 
        bc = bc + 1;
    end
end