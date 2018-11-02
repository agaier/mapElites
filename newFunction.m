function [map, improved] = addToMap(map, newInd, fitness, behavior)
%addToMap - Adds new individuals to map if they can compete for a bin
%
% Syntax:  addToMap(map, newInd, fitness, behavior)
%
% Inputs:
%    map      - [struct] - current map of individuals and performance
%    newInd   - [M X N ] - N candidate individuals
%    fitness  - [1 X N ] - fitness of newInd
%    behavior - [B X N ] - behavior coordinates of newInd
%
% Outputs:
%    output1 - [N X N] - Description
%    output2 - [N X N] - Description
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
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 02-Nov-2018

% TODO:
% * Write todo list
% * Complete todo list


%------------- Input Parsing ------------
parse = inputParser;
parse.addRequired('input1');
parse.addOptional('optionalParam', 'default');

parse.parse(input1,varargin{:});
input1          = parse.Results.input1;
optionalParam   = parse.Results.optionalParam;
%------------- BEGIN CODE --------------

Enter your executable matlab commands here

%------------- END OF CODE --------------