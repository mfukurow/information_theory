function [NTE, rTE] = norm_transfer_entropy(v1, v2, bin1, bin2, delay, niter)

%
%   norm_transfer_entropy.m
%       calculates normalized transfer entropy (v2 -> v1)
%
%   AUTHOR: Matasaburo Fukutomi
%
%   LAST UPDATE:    08/02/2022
%
%   USAGE:  ETE = norm_transfer_entropy(v1, v2, bin1, bin2, delay)
%
%   VARIABLES:
%       inputs
%           v1      a vector of process 1 (hypothetical effect)
%           v2      a vector of process 2 (hypothetical cause)
%           bin1    binning for v1
%           bin2    binning for v2
%           delay   a vector of time points for delay
%           niter   number of iteration
%       outputs
%           NTE     normalized transfer entropy
%           rTE     a vector including transfer entropy calculated 
%                   with randomized data
%

[TE, H1, H2] = transfer_entropy(v1, v2, bin1, bin2, delay);
TE2 = TE / (H1 - H2);

rTE = zeros(niter, 1);

for ii = 1:niter
    [rTE_ii, H1_ii, H2_ii] = transfer_entropy(v1, v2(randsample(length(v2), length(v2))), bin1, bin2, delay);
    rTE(ii) = rTE_ii / (H1_ii - H2_ii);
end

NTE = TE2 - mean(rTE);
rTE = rTE - mean(rTE);

end