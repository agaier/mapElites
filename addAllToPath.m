%addAllToPath - This function adds all folders above it to the path
%
% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: adam.gaier@h-brs.de
% Oct 2017; Last revision: 09-Oct-2017

%------------- BEGIN CODE --------------
% Clean up workspace and add relevant files to path
currentPath = mfilename('fullpath');
addpath(genpath('~/Code/matlabExtensions/'));

% Explicitly define to avoid adding hpc folders over ssh (slow...)
%addpath(genpath(currentPath(1:end-length(mfilename))));
folders = {'domains','src'};
for i=1:length(folders)
    addpath(genpath([currentPath(1:end-length(mfilename)) folders{i}]));
end

