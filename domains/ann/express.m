function pop = express(pop)
%EXPRESS - Converts population genomes into weight and activation matrices
%
% Syntax:  pop = express(pop);
%
% Inputs:
%    pop - population struct with blank  wMat and aMat matrices
%
% Outputs:
%    pop - population struct with filled wMat and aMat matrices
%
%
% Other m-files required: getNodeOrder
% See also: FFNet,  afunct

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Aug 2015; Last revision: 06-Mar-2018

%------------- BEGIN CODE --------------
for iInd = 1:length(pop)
    [order, wMat]  = getNodeOrder(pop(iInd));
    aMat           = pop(iInd).nodes(3,order);
    pop(iInd).aMat = aMat;
    pop(iInd).wMat = wMat;
end
%------------- END OF CODE --------------













