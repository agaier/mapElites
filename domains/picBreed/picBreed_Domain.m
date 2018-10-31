function d = picBreed_Domain
%picBreed_Domain - Domain parameters for the picBreed domain
%
%
% Syntax:  d = xor_Domain
%
% Inputs:
%    nInputs - number of inputs in XOR neural network
%    input2 - Description
%    input3 - Description
%
% Outputs:
%    output1 - Description
%    output2 - Description
%
% Example: 
%    Line 1 of example
%    Line 2 of example
%    Line 3 of example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Aug 2015; Last revision: 25-Sep-2017

%------------- Input Parsing ------------

%------------- BEGIN CODE --------------

d.name = 'picBreed';
rmpath( genpath('domains')); addpath(genpath(['domains/' d.name '/']));

% Functions
d.objFun   = 'picBreed_FitnessFunc' ;
d.stop     = 'picBreed_StopCriteria';
d.indVis   = 'picBreed_IndVis';

% Initial Network Topology
d.inputs  = 2;
d.outputs = 1;
d.activations = [1 ones(1,d.inputs) 2]; % Bias, Linear inputs, Unsigned Step
d.actRange = [1 2 10 11]; % linear, unsigned step, squared, cos
d.weightCap = 2;
d.initialSet = '';

% CPPN Settings
d.substrateDims = [21 21]; 
[X,Y] = meshgrid(linspace(-2,2,d.substrateDims(1)),linspace(-2,2,d.substrateDims(2)));
d.substrate = [X(:) Y(:)];

% Misc
d.minFit = 0;

%------------- END OF CODE --------------
