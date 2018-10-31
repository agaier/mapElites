function [value, string] = afunct(func, x )
%% afunct - Look up for activation functions encoded as ints
% Syntax:  [value] = afunct(func, x )
%
% Inputs:
%    func       - [int]     - activation function ID number
%    x          - [1�N]     - raw output activation 
%
% Outputs:
%    value      - [1�N]     - value of after activation function is applied
%
%     case 1  % Linear
%     case 2  % Unsigned Step Function
%     case 3  % Unsigned higher slope sigmoid
%     case 4  % Gausian with mean 0 and sigma 1
%     case 5  % Signed higher slope sigmoid
%     case 6  % Sin activation
%     case 7  % Absolute value
%     case 8  % Absolute square root
%     case 9  % Signed Step Function
%     case 10 % Squared
%     case 11 % Cosine
%     case 12 % Softplus
%     case 13 % ReLU
%
% See also: express, FFNet

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 06-Mar-2018

%------------- BEGIN CODE --------------

switch func
    case 1 % Linear
        value = x;
        string = 'lin';
    case 2 % Unsigned Step Function
        value = (x>0.5);
        string = 'step_{+}';
    case 3 % Unsigned higher slope sigmoid
        value = (1./(1+exp(-4.9*x)));
        string = 'sig_{+}';
    case 4 % Gausian with mean 0 and sigma 1
        value = (exp(-(x-0).^2/(2*1^2)));
        string = 'gaus';
    case 5 % Signed higher slope sigmoid
        value = (2./(1+exp(-4.9*x)))-1;
        string = 'sig_{+/-}';
    case 6 % Sin activation
        value = sin(pi*x);
        string = 'sin';
    case 7 % Absolute value
        value = abs(x);
        string = 'abs';
    case 8 % Absolute square root
        value = sqrt(abs(x));        
        string = 'sqrt';
    case 9 % Signed Step Function
        value = -1+(x>0)*2;
        string = 'step_{+/-}';
    case 10 % Squared
        value = x.^2;   
        string = '^2';
    case 11 % Cosine
        value = cos(pi*x); 
        string = 'cos';
    case 12 % Softplus
        value = log(1+exp(x));
        string = 'soft+';
    case 13 % ReLU
        value = max(0,x);      
        string = 'relu';
    otherwise
        disp('ERROR in afunct - you did not select a valid activation function. ... Please check the d.actRange configuration parameter')
end
%------------- END OF CODE --------------
