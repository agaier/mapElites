function fitness = rastrigin_FitnessFunc(pop)
%rastrigin_FitnessFunc - Returns fitness on 2D rastrigin benchmark
%
% Syntax:  fitness = rastrigin_FitnessFunc(pop)
%
% Inputs:
%    input1 - [M X N] - N individuals of length M
%
%
% Outputs:
%    fitness - fitness of each individual
%

%
% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

%------------- BEGIN CODE --------------
genes = [pop.genome]';
fitness = (20 + sum(genes.^2 - 10.0 * cos(2 * pi .* genes),2))./40;
fitness = fitness';

%------------- END OF CODE --------------

