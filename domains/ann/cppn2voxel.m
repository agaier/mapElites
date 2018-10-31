function vox = cppn2voxel(ind, d, varargin)
%cppn2voxel - Converts CPPN genes to voxel representation
%
%
% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Aug 2017; Last revision: 20-Aug-2018

%------------- Input Parsing ------------
parse = inputParser;
parse.addRequired('ind');
parse.addRequired('d');
parse.addOptional('vis',  false);

parse.parse(ind,d,varargin{:});
ind          = parse.Results.ind;
d            = parse.Results.d;
vis          = parse.Results.vis;
%------------- BEGIN CODE --------------

%%
if vis; clf;end
%% Express CPPN
output = reshape(expressCppn(ind,d),d.substrateDims);

% HACK: If no pixels full, ALL pixels full (at least it can be expressed)
if all(output==0); output = output + 1; end

Z = padarray(output,[1 1],0,'both').*1;
[X,Y] = meshgrid(linspace(0,1,length(Z)));

if vis 
    % Show CPPN (replace with function)
    figure(1);
    G = digraph(ind.wMat);
    h = plot(G,'Layout','layered','Direction','right','Sources',1:d.inputs+1);
    h.NodeLabel(1:3) = {'Bias', 'X', 'Y'};
    h.NodeLabel(end) = {'Output'};
    yticks('');xticks('');
    title('CPNN');
    
    % Show CPPN output
    figure(2);
    imshow(Z); axis equal off; axis tight; title 'CPPN Output';
end
    
%% Voxelization
    Z = imfill(Z,'holes');
    %Z = bwperim(Z); nZ = 1;
    nZ = 2;
    vox.data = repmat(Z,[1 1 nZ]);
    vox.X = linspace(0,1,length(Z)); 
    vox.Y = vox.X; 
    vox.Z = linspace(0.25,0.75,size(vox.data,3));

    