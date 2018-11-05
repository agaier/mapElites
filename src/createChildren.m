function children = createChildren(map, d)
%createChildren - produce new children through mutation of map elite
%
% Syntax:  children = createChildren(map,nChildren,p,d)
%
% Inputs:
%    map - [struct] - map of individuals and performance
%      .genomes   - [struct] - genotypes of all individuals
%
%    d   - [struct] - recombination/variation parameters
%      .batchSize - [int   ] - number of children to create
%      .recombine - [struct] - recombination parameters of domain
%
% Outputs:
%   children  - [1 X N ] - newly created solutions
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

%------------- BEGIN CODE --------------  
    % Remove empty bins from parent pool
    parentPool = map.genomes(:);
    parentPool(isnan([map.fitness])) = [];
    
    % Uniform random selection of parents from parent pool
    parents = parentPool(randi(length(parentPool),[d.batchSize d.recombine.parents]));
    
    % Create new population from parents
    children = feval(d.breedPop, parents, d.recombine);
%------------- END OF CODE --------------