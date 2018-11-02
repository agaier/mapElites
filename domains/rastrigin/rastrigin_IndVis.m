function picBreed_IndVis(ind,d)
%swingUp_indVis - Visualize individual performance in swing-up domain
%
%
% Syntax:  dswingUp_indVis(ind)
%
% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Dec 2017; Last revision: 05-Dec-2017

%------------- Input Parsing ------------

%------------- BEGIN CODE --------------

%% Elite Surface Approximation
%ind = express(ind);
%ind.pheno = expressCppn(ind,d)

[~, target, output] = picBreed_test(ind.pheno,d);
subplot(3,2,2);
imagesc(target); axis equal; axis tight; title('CPPN Target'); caxis([0 1])

subplot(3,2,4);
imagesc(output); axis equal; axis tight; title('CPPN Output'); caxis([0 1])

%% Elite Network
subplot(3,2,6);
G = digraph(ind.wMat);
h = plot(G,'Layout','layered','Direction','right','Sources',1:d.inputs+1);

for i=1:length(ind.aMat)
   [~,labels{i}] = afunct(ind.aMat(i),0);
end
h.NodeLabel = labels;
h.NodeLabel(1:3) = {'Bias', 'X', 'Y'};
h.NodeLabel(end) = {'Output'};
yticks('');xticks('');
title('ANN');

%------------- END OF CODE --------------
