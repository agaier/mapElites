function [fitness, behavior, miscVal, pop] = rastrigin_Evaluate(pop, d)
%rastrigin_getQd - Gets the Quality and Diversity measures of a population
%
% Syntax:  [fitness, behavior] = rastrigin_getQd(startPop, d)
%
% Inputs:
%    pop      - [M X N ] - N individuals of length M
%    d        - [struct] - domain hyperparameter struct
%
% Outputs:
%    fitness  - [1 X N ] - fitness of startPop
%    behavior - [B X N ] - behavior coordinates of startPop
%
% Other m-files required: d.objFun, d.getBc

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * Write todo list
% * Complete todo list

%------------- BEGIN CODE --------------

% Get fitness of each individual
fitness = feval(d.objFun, pop);

% Get feature coordinates of each individual
behavior = feval(d.getBc, pop);

% Get miscellaneous values of each individual
miscVal{1} = rand (1,length(pop));
miscVal{2} = zeros(1,length(pop));

%------------- END OF CODE --------------