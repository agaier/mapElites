% demo - MAP-Elites demo usage script
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018


%% Load problem domain
clear; figure(1); clf
d = rastrigin_Domain;

% Run MAP-Elites with default parameters
map = mapElites(d);

%% Run same map for a little longer
map = mapElites(d, 'startMap',map);

%% Increase resolution and number of children
d.mapDims.res = [20 25];% Set resolution of map
d.nEvals      = 2^13;   % Set evaluation budget
d.nInitial    = 2^7;    % Set number of initial random samples
d.batchSize   = 2^8;    % Set number of children to create at one time

map = mapElites(d);

%% Run at higher res
d.mapDims.res = [100 100];% Set resolution of map
d.nEvals      = 2^16;     % Set evaluation budget
d.initial     = 2^7;      % Set number of initial random samples
d.batchSize   = 2^9;      % Set number of children to create at a time

map = mapElites(d,'genPerVis',2^3); % Don't watch every generation

%% Don't watch at all, just view at end
clf; drawnow;
map = mapElites(d,'genPerVis',0); % Don't watch every generation
viewMap(map);                     % View produced map at end

%% Save progress for later as gif
map = mapElites(d,'genPerVis',2^3,'gifMap','rastMap.gif');
% web('rastMap.gif') % view gif in browser

%% Save progress as data
[~, record] = mapElites(d,'genPerVis',0,'genPerRecord',2^3);

%% Display run details from record
subplot(2,1,1)
plot(record.evals,record.improved);
title('Rate of Improvement');
xlabel('Function Evaluations (log scale)');
ylabel(['Proportion of Newly Created' newline 'Children Entering Map'])
grid on; set(gca,'XScale','log','YLim',[0 1]); axis square;

eighths = length(record.evals)/8:length(record.evals)/8:length(record.evals);
for i=1:8
    subplot(4,4,8+i);
    id = eighths(i);
    h = viewMap(record.map(id)); % Alter graphics afterward
    h(1).GridLineStyle = 'none';
    h(1).XTick = [];
    h(1).YTick = [];
    h(3).FontSize = 8;
    title(['Eval ' int2str(record.evals(id))])
end



%------------- END OF CODE --------------