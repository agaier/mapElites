function children = rastrigin_Variation(parents, d)
%addToMap - Adds new individuals to map if they can compete for a bin
%
% Syntax:  addToMap(map, newInd, fitness, behavior)
%
% Inputs:
%    map      - [struct] - current map of individuals and performance
%    d        - [struct] - recombination/variation parameters
%
% Outputs:
%    children - [1 X N ] - newly created individuals 
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * Write todo list
% * Complete todo list

%#ok<*AGROW>
%------------- BEGIN CODE --------------

for i=1:length(parents)
    % Mutate
    children(i).genome = parents(i).genome + (randn(2,1).*d.mutSigma);
    
    % Bind Values
    children(i).genome(children(i).genome<d.range(1)) = d.range(1);
    children(i).genome(children(i).genome>d.range(2)) = d.range(2);
end




%------------- END OF CODE --------------