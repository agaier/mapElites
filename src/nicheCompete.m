function [replaced, replacement] = nicheCompete(map, fitness, behavior)
%nicheCompete - results of competition with map's existing elites
%
% Syntax:  [replaced, replacement] = nicheCompete(newInds,fitness,map,p)
%
% Inputs:
%    map      - [struct] - current map of individuals and performance
%    fitness  - [1 X N ] - fitness of newInd
%    behavior - [B X N ] - behavior coordinates of newInd
%
% Outputs:
%   replaced    - [NX1] - Linear index of map cells to recieve replacements
%   replacement - [NX1] - Index of newInds to replace current elites in niche
%   mapLinIndx  - [NX1] - Index of current elites (for rank testing only)
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * With N dimensions (see todo note below)

%------------- BEGIN CODE --------------
% Get bin of each individual based on behavior
nDims = size(behavior,1);
for iDim = 1:nDims
    bin(iDim,:) = discretize(behavior(iDim,:),map.edges{iDim}); %#ok<AGROW>
end

% Get best in each bin
% * First sort by bin then fitness (best fitness first). 
% * Then remove all but the first (highest fitness) for each bins combo
[sortedByFeatureAndFitness, indxSortOne] = sortrows([bin; fitness]');
[~, indxSortTwo] = unique(sortedByFeatureAndFitness(:,[1 2]),'rows');
bestIndex  = indxSortOne(indxSortTwo);
bestBin    = bin(:,bestIndex);
mapLinIndx = sub2ind(size(map.fitness),bestBin(1,:),bestBin(2,:)); % <-- TODO: Higher dimensions!

% Compare to already existing samples
improvement  = ~(fitness (bestIndex) >= map.fitness(mapLinIndx)); % comparisons to NaN are always false
improvement(isnan(fitness(bestIndex))) = false;                   % but nans are not better than nans
replacement = bestIndex (improvement)';
replaced    = mapLinIndx(improvement);

%------------- END OF CODE --------------