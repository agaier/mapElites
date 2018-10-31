function [pop, fitness] = picBreed_FitnessFunc(pop,d)
%xor_FitnessFunc - Evaluates fitness of population on XOR test problem
%
% Syntax:  pop = xor_FitnessFunc(pop,d);
%
% Inputs:
%    pop - population struct with empty 'fitness' field
%    d   - domain hyperparameter script
%
% Outputs:
%    fitness - fitness of each individual
%    pop - population struct with filled 'fitness' field
%
% Other m-files required: picBreed_test
% See also: picBreed_test, picBreed_Domain, picBreed_StopCriteria

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Aug 2015; Last revision: 25-Sep-2017

%------------- BEGIN CODE --------------
pop = express(pop);

parfor iInd = 1:length(pop)
    ind = pop(iInd);
    ind.pheno = expressCppn(ind,d)
    fitness(iInd) = picBreed_test(ind.pheno,d);
    pop(iInd).fitness = fitness(iInd);
    pop(iInd).pheno   = ind.pheno;
end

%------------- END OF CODE --------------

