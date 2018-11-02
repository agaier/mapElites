% demo - MAP-Elites demo usage script
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * Write todo list
% * Complete todo list


%% Load problem domain
clear
d = rastrigin_Domain;

% Run MAP-Elites with default parameters
map = mapElites(d);

%% Run same map for a little longer
map = mapElites(d, 'startMap',map);

%% Increase resolution and number of children
d.mapDims.res = [20 25];% Set resolution of map
d.nEvals      = 2^13;   % Set evaluation budget
d.initial     = 2^7;    % Set number of initial random samples
d.batchSize   = 2^8;    % Set number of children to create at one time

map = mapElites(d);

%% Run at high res
d.mapDims.res = [100 100];% Set resolution of map
d.nEvals      = 2^17;     % Set evaluation budget
d.initial     = 2^7;      % Set number of initial random samples
d.batchSize   = 2^9;      % Set number of children to create at a time

map = mapElites(d,'genPerVis',2^3); % Don't watch every generation

%% Don't watch at all, just view at end
clf; drawnow;
map = mapElites(d,'genPerVis',0); % Don't watch every generation
viewMap(map);                     % View produced map at end

%% Save progress for later as gif
map = mapElites(d,'genPerVis',2^3,'gifMap','rastMap.gif'); % Record progress as animated gif
% web('rastMap.gif') % view gif in browser

%------------- END OF CODE --------------