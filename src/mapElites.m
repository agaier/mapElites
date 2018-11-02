function [map,record] = mapElites(domain, varargin)
%mapElites - Multi-dimensional Archive of Phenotypic Elites algorithm
%
% Syntax:  map = mapElites(problemDomain, hyperparameters, map);
%
% Inputs:
%   fitnessFunction - [funct ] - returns fitness of vector of individuals
%   map             - [struct] - initial solutions in F-dimensional map
%   p               - [struct] - Hyperparameters for algorithm, visualization, and data gathering
%   d               - [struct] - Domain definition
%
% Outputs:
%   map    - struct - population archive
%   percImproved    - percentage of children which improved on elites
%   h      - [1X2]  - axes handle, data handle
%
%

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
parse.addRequired('domain');
parse.addOptional('startMap', []);
parse.addOptional('genPerVis', 2^3);
parse.addOptional('gifMap', false);

parse.parse(domain,varargin{:});
d        = parse.Results.domain;
startMap = parse.Results.map;
visMod   = parse.Results.genPerVis;
gifMap   = parse.Results.gifMap;

%------------- BEGIN CODE --------------
%% Fill initial map
if ~isempty(startMap)
    map = startMap;
else
    map = createMap(d.mapDims, d.sampleInd);
    startPop = feval(d.randInd, d.nInitial,d.recombine);
    [fitness, behavior, misc, startPop] = feval(d.evaluate, startPop, d); 
    map = addToMap(map, startPop, fitness, behavior, misc);    
end

%% MAP-Elites
evalTime = 0; iGen = 1;
while (iGen <= p.nGens)
    %% 1) Create and Evaluate Children
    % Create children which satisfy geometric constraints for validity
    nMissing = p.nChildren; children = [];
    
    while nMissing > 0
        indPool = createChildren(map, nMissing, p, d);
        validFunction = @(genomes) feval(d.validate, genomes, d);
        [validChildren,~,nMissing] = getValidInds(indPool, validFunction, nMissing);
        children = [children; validChildren]; %#ok<AGROW>
    end   
    
    evalStart = tic;
    [fitness, values] = fitnessFunction(children); %% TODO: Speed up without anonymous functions
    evalTime = evalTime + toc(evalStart);    

    %% 2) Add Children to Map   
    [replaced, replacement] = nicheCompete(children,fitness,map,d);  
    map = updateMap(replaced,replacement,map,fitness,children,...
                        values,d.extraMapValues);  
         
    % Improvement Stats
    percImproved(iGen) = length(replaced)./p.nChildren; %#ok<AGROW>

    % View Illuminatiom Progress?
    if p.display.illu && ~mod(iGen,p.display.illuMod)
        set(h(2),'CData',flip(map.fitness),'AlphaData',~isnan(flip(map.fitness)))
        colormap(h(1),parula(16)); drawnow;
    end
    
iGen = iGen+1; if ~mod(iGen,2^5);disp([char(9) 'Illumination Generation: ' int2str(iGen) ' - Improved: ' num2str(percImproved(end)*100) '%']);end;
end

if percImproved(end) > 0.05; disp('Warning: MAP-Elites finished while still making improvements ( >5% / generation )');end


%------------- END OF CODE --------------