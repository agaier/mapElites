function output = FFNet (wMat, aMat, input, d)
%% FFNet - Returns activation of a FFANN given: input, weights, and activation functions
% Given an ordered weight matrix, corresponding activation matrix, initial
% input vector, returns the result of a Feed Forward Neural Network in
% vector form. Activations are integers corresponding to activation 
% functions set in 'afunct.m'. The number of outputs are set 
% within the parameter (p) struct.
%
% Note: Bias is treated as any other input and must be set in the input
% vector before passing to this function
%
% Syntax:  output = FFNet (wMat, aMat, input, d)
%
% Inputs:
%    wMat       - [N�N]     - weight matrix
%    aMat       - [1�N]     - activation functions of each node
%    input      - [1�M]     - input activation of neural network 
%    d          - domain struct
%     .outputs  - number of outputs to return
%
% Outputs:
%    output     - [1�d.outputs] - activation level of output neurons
%
% See also: afunct.m, express 

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 06-Mar-2018

%------------- BEGIN CODE --------------
numNodes = length(wMat);
a = zeros(size(input,1),numNodes);
a(:,1:size(input,2)) = input;

for i=d.inputs+2:numNodes % skip input and bias
    % get activation for next node in network
    a(:,i) = a*wMat(:,i);
    a(:,i) = afunct(aMat(i),a(:,i));
end

output = a(:,(end+1-d.outputs):end);
end
%------------- END OF CODE --------------