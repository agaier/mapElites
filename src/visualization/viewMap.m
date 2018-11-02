function handle = viewMap(map, value)
%viewMap - View results of 2D map
%
% Syntax:  viewMap(map)
%          viewMap(map, 'otherValue')
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

%------------- Input Parsing ------------
if nargin < 2; value = 'fitness'; end
eval(['mapMat = map.' value ';']);

%------------- BEGIN CODE --------------
mapRes = size(mapMat);
edges = map.edges;

% Plot Map values
imgHandle = imagesc(flipud(rot90(mapMat))); % Top corner = [0,0] in imagesc
set(imgHandle,'AlphaData',~isnan(imgHandle.CData)*1) % Don't show nans

% Set labels on bin borders instead of centers
fitPlot = gca;
set(fitPlot,...
    'XTick', linspace(0.5,mapRes(1)+0.5,mapRes(1)+1), ...
    'YTick', linspace(0.5,mapRes(2)+0.5,mapRes(2)+1),...
    'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k',...
    'LineWidth',2 ...    
    );

% Label Axis
xlabel([map.label{1} '\rightarrow']);
ylabel([map.label{2} '\rightarrow']);
xticklabels(edges{1});
yticklabels(edges{2}(end:-1:1));

% Set Color Bar
hcb = colorbar;
set(get(hcb,'Title'),'String',capitalize(value))
hcb.FontSize = 12;


drawnow; 

% Output handles to graphics objects
handle(1) = fitPlot;
handle(2) = imgHandle;
handle(3) = hcb;


%------------- END OF CODE --------------