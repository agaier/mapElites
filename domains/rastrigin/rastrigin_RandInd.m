function randomInds = rastrigin_RandInd(nInds, d)
%rastrigin_RandInd - Creates N random children of 2D rastrigin form
%
% Syntax:  randomInds = rastrigin_RandInd(nInds)
%
% Inputs:
%    nInds  - [int   ] - number of children to be produced
%    d      - [struct] - genome parameters
%
% Outputs:
%    randomInds - [1 X N] - N random inds
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

% Create random genomes
unitRandom   = rand(2,nInds);
scaledRandom = (unitRandom*(d.range(2)-d.range(1))) + d.range(1);

% Assign genomes
for i=1:nInds; randomInds(i).genome = scaledRandom(:,i); end %#ok<AGROW>

%------------- END OF CODE --------------