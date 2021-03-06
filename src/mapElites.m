function [map,record] = mapElites(domain, varargin)
%mapElites - Multi-dimensional Archive of Phenotypic Elites algorithm
%
% Syntax:  map = mapElites(problemDomain, hyperparameters, map);
%
% Inputs:
%   domain     - [struct] - Domain definition
%   startMap   - [struct] - (Optional) previous map to start with
%   genPerVis  - [int   ] - (Optional) gens per visualization (-1 for off)
%   gifMap     - [file  ] - (Optional) filename to record gif of progress
%
% Outputs:
%   map        - [struct] - population archive created at end of run
%   record     - [struct] - 
%

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% Inria Nancy - Grand Est
% email: adam.gaier@{h-brs.de, inria.fr}
% Nov 2018; Last revision: 06-Nov-2018

%------------- Input Parsing ------------
parse = inputParser;
parse.addRequired('domain');
parse.addOptional('startMap', []);
parse.addOptional('genPerVis', 2^0);
parse.addOptional('gifMap', false);
parse.addOptional('genPerRecord', false);

parse.parse(domain,varargin{:});
d        = parse.Results.domain;
startMap = parse.Results.startMap;
visMod   = parse.Results.genPerVis;
gifMap   = parse.Results.gifMap;
recMod   = parse.Results.genPerRecord;

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

if gifMap;gif(gifMap);end

%% MAP-Elites
nEvals = d.nInitial; gen = 1;
while (nEvals <= d.nEvals-d.batchSize)
    % Next three lines is the whole algorithm
    children = createChildren(map, d);
    [fitness, behavior, misc, children] = feval(d.evaluate, children, d);
    [map, improved] = addToMap(map, children, fitness, behavior, misc);  
        
    % Visualization and Record Keeping
    nEvals = nEvals + length(children) %#ok<NOPRT>
    gen = gen+1; 
    if ~mod(gen, visMod); viewMap(map); if gifMap; gif; end; end  
    if ~mod(gen, recMod)
        recorded(gen) = true; %#ok<AGROW>
        record.evals(gen) = nEvals;
        record.improved(gen) = improved; 
        record.map(gen) = map; % Beyond trivial runs often very large!
    end
end

%% Clean up data struct
if recMod
    record.evals = record.evals(recorded);
    record.improved = record.improved(recorded);
    record.map = record.map(recorded);
end

% Include method for inspecting individuals in map
if isfield(d,'indVis');map.view=@(x1,x2) feval(d.indVis,map,[x1,x2],d);end


%------------- END OF CODE --------------