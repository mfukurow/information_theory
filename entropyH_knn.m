function H = entropyH_knn(dat, k, distanceMethod)

%
%   entropyH_knn.m
%       calculates Shannon's entropy using k-nearest
%       neighbor estimator
%
%   AUTHOR: Matasaburo Fukutomi
%
%   LAST UPDATE:    08/04/2022
%
%   USAGE:  H = entropyH_knn(dat, k, distanceMethod)
%
%   VARIABLES:
%       inputs
%           dat = a vector (or matrix) containing data
%                 each colomn includes each variable
%           k   = k used for k-nearest neighbor method
%           distanceMethod
%               = a name of method for knn
%       outputs
%           H   = Shannon's entropy
%

[n, m] = size(dat);
[~, knndist] = knnsearch(dat, dat, 'K', max(k) + 1, ...
    'Distance', distanceMethod);
sum_knndist = sum(log(knndist(:, k + 1)), 1);
H = m / n * sum_knndist + m / 2 * log(pi) ...
    - gammaln(m / 2 + 1) - psi(k) + log(n);

end