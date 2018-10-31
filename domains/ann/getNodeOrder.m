function [ Q, wMat ] = getNodeOrder(ind)
%getNodeOrder - Topological sort of nodes, and resulting weight matrix
% Ordering nodes also ensures that the networks are feed forward 
%
% Syntax:  [ Q, wMat ] = getNodeOrder(ind)
%
% Inputs:
%    ind    - [struct]          - individual struct
%       .nodes    [3 × nNodes]  - see below
%                 (1,:) == Node ID
%                 (2,:) == Type (1=input, 2=output 3=hidden 4=bias)
%                 (3,:) == Activation Function (see 'afunct.m)
%       .conns    [5 × nConns]  - see below
%                 (1,:) == Innovation Number
%                 (2,:) == Source
%                 (3,:) == Destination
%                 (4,:) == Weight 
%                 (5,:) == Enabled?
% Outputs:
%    Q     - [1 × nNodes]      - Indices of topologically sorted nodes
%    wMat  - [nNodes × nNodes] - Weight matrix of feed forward network
%
% Example: 
%     for iInd = 1:length(pop)
%         [order, wMat]  = getNodeOrder(pop(iInd));
%         aMat           = pop(iInd).nodes(3,order);
%         pop(iInd).aMat = aMat;
%         pop(iInd).wMat = wMat;    
%     end

%
% Other m-files required: quickSetDiff
% See also: initializePop, express

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Feb 2018; Last revision: 06-Mar-2018

%% Build connection matrix
connMat     = zeros(size(ind.nodes,2));
hidden      = ind.nodes(2,:) == 3;
hidlookup   = ind.nodes(1,hidden);
lookup      = [1:(size(ind.nodes,2) - length(hidlookup)), hidlookup];

for i=1:size(ind.conns,2)
    in  = (lookup == ind.conns(2,i));
    out = (lookup == ind.conns(3,i));
    connMat(in, out) = ind.conns(4,i);    
end
wMat = connMat;
connMat(connMat~=0) = 1; 

%% Topological Sort
incoming_edges = sum(connMat,1);
Q = find(incoming_edges==0); % Start with nodes with no connection to them

for i=1:length(connMat)
    if isempty(Q) || i > length(Q); Q = []; break; end % found a cycle
    outgoing_edges = connMat(Q(i),:);
    incoming_edges = incoming_edges - outgoing_edges;
    Q = [Q , quickSetDiff(find(incoming_edges==0),Q)]; %#ok<AGROW>
    if sum(incoming_edges) == 0; break; end
end

%% Order weights to weight matrix
wMat = wMat(Q,Q);

