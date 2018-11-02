function d = rastrigin_Domain
%rastrigin_Domain - Domain parameters solving demo 2d rastrigin
%
%
% Syntax:  d = rastrigin_Domain
%
% Inputs:
%
% Outputs:
%    output1 - Description
%    output2 - Description
%
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2

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
d.newChild = 'rastrigin_CreateChild';
d.randInd  = 'rastrigin_RandInd';
d.getBc    = 'rastrigin_GetBehavior';
d.stop     = 'rastrigin_StopCriteria';
d.indVis   = 'rastrigin_IndVis';

% MAP-Elites settings
d.nInitial   = 2^6;
d.batchSize  = 2^7;
d.nEvals     = 2^10;

d.mapDims.res  = [8 10];
d.mapDims.min  = [-2 -1];
d.mapDims.max  = [ 2  1];
d.mapDims.misc = {'otherVal1', 'otherVal2'}; 

% Genome
% * Supported representations: struct % todo: row vectors as well
d.sampleInd.genome = nan(2,1);

% Recombination parameters
d.recombine.range       = [-2 2];
d.recombine.mutSigma    = 0.2;    


%------------- END OF CODE --------------
