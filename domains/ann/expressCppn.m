function [output] = expressCppn(ind, d)
%expressCPPN - Returns CPPN output for every input from substrate
%
% Syntax:  [output] = expressCppn(ind, d)
%
% Inputs:
%    ind - [struct] - Single individual
%     .wMat  - [N�N]  - weight matrix
%     .aMat  - [1�N]  - activation functions of each node
%    d              - domain struct
%     .substrate      - substrate coordinates
%     .outputs        - number of outputs to return in FFNet
%
% Outputs:
%    output - Value(s) for every substrate input
%
% Example: 
%    Line 1 of example
%    Line 2 of example
%    Line 3 of example
%
% Other m-files required: FFNet
%
% See also: FFNet,  OTHER_FUNCTION_NAME2

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Mar 2017; Last revision: 23-Mar-2017

%------------- BEGIN CODE --------------
input  = d.substrate;
output = FFNet(ind.wMat,ind.aMat,[ones(size(input,1),1) input],d)';    
output = reshape(output, d.substrateDims);

%------------- END OF CODE --------------