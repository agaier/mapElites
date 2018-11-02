function [map, improved] = addToMap(map, newInd, fitness, behavior, misc)
%addToMap - Adds new individuals to map if they can compete for a bin
%
% Syntax:  addToMap(map, newInd, fitness, behavior)
%
% Inputs:
%    map      - [struct] - current map of individuals and performance
%    newInd   - [M X N ] - N candidate individuals
%    fitness  - [1 X N ] - fitness of newInd
%    behavior - [B X N ] - behavior coordinates of newInd
%    misc     - {1 X A ] - Cell array with A different misc values
%
% Outputs:
%    map      - [struct] - map updated with new individuals
%    improved - [1 X 1 ] - percentage of children that were added to map
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * Write todo list
% * Complete todo list

%------------- BEGIN CODE --------------

[replaced, replacement] = nicheCompete(map, newInd, fitness, behavior);
map = updateMap(replaced, replacement, map, newInd, fitness, misc);

improved = length(replaced)./length(newInd);

%------------- END OF CODE --------------