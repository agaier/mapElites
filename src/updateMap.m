function map = updateMap(replaced,replacement,map, newInd, fitness, misc)  %#ok<INUSD>
%updateMap - Replaces all values in a set of map cells
%
% Syntax:  map = updateMap(replaced,replacement,map,fitness,drag,lift,children)
%
% Inputs:
%   replaced    - [1 X M ]  - linear index of map cells to be replaced
%   replacement - [1 X M ]  - linear index of children values to place in map
%   map         - [struct]  - population archive
%   fitness     - [1 X N ]  - fitness values of new individuals
%   genomes     - [1 X N ]  - genes of new individuals
%   misc        - [cell  ]  - extra values of interest to record
%
% Outputs:
%   map         - struct - population archive
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

%------------- BEGIN CODE --------------

% Replace individuals and fitness
map.fitness(replaced) = fitness(replacement);
map.genomes(replaced)  = newInd(replacement);

% Replace Miscellaneous Map values
for iValues = 1:length(map.misc)
    eval( ['map.' map.misc{(iValues)} '(replaced) = misc{' int2str(iValues) '}(replacement);'] )
end

%------------- END OF CODE --------------