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
    children = createChildren(map, d);
    [fitness, behavior, misc, children] = feval(d.evaluate, children, d);
    [map, improved] = addToMap(map, children, fitness, behavior, misc);  
    nEvals = nEvals + length(children)
    
    % Visualization and Record Keeping
    gen = gen+1; 
    if ~mod(gen, visMod); viewMap(map); if gifMap; gif; end; end  
    if ~mod(gen, recMod)
        record.evals(gen) = nEvals;
        record.map(gen) = map; 
        record.improved(gen) = improved; 
        recorded(gen) = true; %#ok<AGROW>
    end
end

%% Clean up data struct
if recMod
    record.evals = record.evals(recorded);
    record.map = record.map(recorded);
    record.improved = record.improved(recorded);
end

%------------- END OF CODE --------------