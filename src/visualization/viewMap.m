function handle = viewMap(map, value)
%viewMap - View results of 2D map
%
% Syntax:  viewMap(map, 'fitness')
%
% Inputs:
%   map   - [struct] - map struct
%   value - [string] - name of map field to view (default: 'fitness')
%
% Outputs:
%   h(1)    - handle of figure
%   h(2)    - handle of map image
%   h(3)    - handle of colorbar
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * Double check orientation is correct
% * Complete todo list

%------------- Input Parsing ------------
if nargin < 2
    value = 'fitness';
end
eval(['mapMat = map.' value ';']);

%------------- BEGIN CODE --------------
mapRes = size(mapMat);
edges = map.edges;

yOffset = [0.5 -0.0 0];
imgHandle = imagesc(flipud(rot90(mapMat))); fitPlot = gca;
set(imgHandle,'AlphaData',~isnan(imgHandle.CData)*1)
xlabel([map.label{1} '\rightarrow']);
ylab = ylabel([ map.label{2} '\uparrow']);
set(ylab,'Rotation',0,'Position',get(ylab,'Position')-yOffset)


set(fitPlot,...
    'XTick', linspace(0.5,mapRes(1)+0.5,mapRes(1)+1), ...
    'YTick', linspace(0.5,mapRes(2)+0.5,mapRes(2)+1),...
    'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k',...
    'LineWidth',2 ...    
    );

xticklabels(edges{1});
yticklabels(edges{2}(end:-1:1));

hcb = colorbar;
set(get(hcb,'Title'),'String',capitalize(value))
hcb.FontSize = 12;

% Output handles to graphics objects
drawnow; 
h(1) = fitPlot;
h(2) = imgHandle;
h(3) = hcb;


%------------- END OF CODE --------------