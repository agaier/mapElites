function d = rastrigin_Domain
%rastrigin_Domain - Domain parameters solving demo 2d rastrigin
%
%
% Syntax:  d = rastrigin_Domain

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * Heavily comment (use this as documentation)

%------------- BEGIN CODE --------------

d.name = 'rastrigin';
rmpath( genpath('domains')); addpath(genpath(['domains/' d.name '/']));

% Functions
d.evaluate = 'rastrigin_Evaluate';
d.objFun   = 'rastrigin_FitnessFunc' ;
d.getBc    = 'rastrigin_GetBehavior';
d.breedPop = 'rastrigin_Variation';
d.randInd  = 'rastrigin_RandInd';

% MAP-Elites settings
d.nInitial   = 2^6;
d.batchSize  = 2^6;
d.nEvals     = 2^10;

d.mapDims.res  = [8 10];
d.mapDims.label= {'x-coord','y-coord'};
d.mapDims.min  = [-2 -1];
d.mapDims.max  = [ 2  2];
d.mapDims.misc = {'otherVal1', 'otherVal2'}; 

% Genome
% * Supported representations: struct % todo: row vectors as well
d.sampleInd.genome = nan(2,1);

% Recombination parameters
d.recombine.range       = [-2 2];
d.recombine.mutSigma    = [1/8; 1/10];   
d.recombine.parents     = 1;


%------------- END OF CODE --------------
