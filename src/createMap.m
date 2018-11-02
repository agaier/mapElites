function map = createMap(mapDims, sampleInd)
%createMap - Defines map struct and behavior space bin divisions
%
% Syntax:  map = createMap(mapDims, sampleInd)
%
% Inputs:
%    mapDims
%      .res       - [ 1XN ] - number of bins in N dimensions
%      .min       - [ 1XN ] - number of bins in N dimensions
%      .max       - [ 1XN ] - number of bins in N dimensions
%      .misc      - [cell ] - strings with names of additional values
%    sampleInd    - [ 1X1 ] - example individual
%
% Outputs:
%    map          - [struct] - Map/archive
%      .edges       - {1  X N }            - map partitions per dim
%      .fitness     - [M(1) X M(2) X M(N)] - fitness value in each bin
%      .genomes     - [M(1) X M(2) X M(N)] - individual in each bin
%      .otherVals   - [M(1) X M(2) X M(N)] - other value in each bin
%      .otherVals   - [M(1) X M(2) X M(N)] - other value in each bin


% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * Write todo list
% * Complete todo list

%------------- BEGIN CODE --------------

for i=1:length(mapDims.res)
    map.edges{i} = linspace(mapDims.min(i),mapDims.max(i),mapDims.res(i)+1);
    map.edges{i}(1)  = -Inf;
    map.edges{i}(end) = Inf;
end
map.label = mapDims.label;
map.fitness = NaN(mapDims.res);
map.genomes = repmat(sampleInd, [mapDims.res]);

% Include additional values of interest per bin
map.misc = mapDims.misc;
for iValues = 1:length(map.misc)
    eval(['map.' map.misc{iValues} ' = NaN(mapDims.res);']);
end




%------------- END OF CODE --------------