function [fitness, target, pixel, diff] = picBreed_test(pixel, d)

% Create Thresholded Rastrigin of same resolution as input
input = d.substrate;
rastrigin = nan(d.substrateDims);
rastrigin(:) = (10*size(input,2) + sum(input .^2 - 10.0 * cos(2 * pi .* input),2))./40;
rastrigin = afunct(2, rastrigin);

% Is it the same?
diff = sum(xor(pixel(:),rastrigin(:))) / (d.substrateDims(1)*d.substrateDims(2));
fitness = 1/(1+diff);
target = rastrigin;