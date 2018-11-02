function children = createChildren(map, d)
%createChildren - produce new children through mutation of map elite
%
% Syntax:  children = createChildren(map,nChildren,p,d)
%
% Inputs:
%   map         - Population struct
%    .fitness
%    .genes
%   nChildren - number of children to create
%   p           - SAIL hyperparameter struct
%    .mutSigma      - sigma of gaussian mutation applied to children
%   d           - Domain description struct
%    .dof           - Degrees of freedom (genome length)
%
% Outputs:
%   children - [nChildren X genomeLength] - new solutions
%
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: adam.gaier@h-brs.de
% Jun 2016; Last revision: 17-Oct-2017

%------------- BEGIN CODE --------------  
    % Remove empty bins from parent pool
    parentPool = map.genomes(:);
    parentPool(any(isnan([parentPool.genome]))) = []; 
    
    % Uniform random selection of parents from parent pool
    parents = parentPool(randi(length(parentPool),[d.batchSize d.recombine.parents]));
    
    % Create new population from parents
    children = feval(d.breedPop, parents, d.recombine);
%------------- END OF CODE --------------