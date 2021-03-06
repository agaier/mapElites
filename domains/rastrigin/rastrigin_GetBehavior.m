function behavior = rastrigin_GetBehavior(pop)
%rastrigin_getFeatures - Returns features of 2D rastrigin benchmark
% Features here are merely the x,y coordinates (e.g. the genome itself)
%
% Syntax:  behavior = rastrigin_GetBehavior(pop)
%
% Inputs:
%    pop      - [M X N] - N individuals of length M
%
%
% Outputs:
%    behavior - [B X N] - behavior characterization of each individual
%

%
% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

%------------- BEGIN CODE --------------

behavior = [pop.genome];

%------------- END OF CODE --------------

