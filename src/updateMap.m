function map = updateMap(replaced,replacement,map, newInd, fitness, misc)  %#ok<INUSD>
%updateMap - Replaces all values in a set of map cells
%
% Syntax:  map = updateMap(replaced,replacement,map,fitness,drag,lift,children)
%
% Inputs:
%   replaced    - [1XM]  - linear index of map cells to be replaced
%   replacement - [1XM]  - linear index of children values to place in map
%   map         - struct - population archive
%   fitness     - [1XN]  - Child fitness
%   genomes       - [NXD]  - Child genomes
%   values      - [1XN]  - extra values of interest, e.g. 'cD'
%
% Outputs:
%   map         - struct - population archive
%
%
% See also: createMap, nicheCompete

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: adam.gaier@h-brs.de
% Jun 2016; Last revision: 02-Aug-2017

%------------- BEGIN CODE --------------

% Replace individuals and fitness
map.fitness(replaced) = fitness(replacement);
map.genomes(replaced)  = newInd(replacement);

% Replace Miscellaneous Map values
for iValues = 1:length(map.misc)
    eval( ['map.' map.misc{(iValues)} '(replaced) = misc{' int2str(iValues) '}(replacement);'] )
end

%------------- END OF CODE --------------