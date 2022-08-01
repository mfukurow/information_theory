function [ETE, rTE] = e_transfer_entropy(v1, v2, bin1, bin2, delay, niter)

%
%   e_transfer_entropy.m
%       calculates effective transfer entropy (v2 -> v1)
%
%   AUTHOR: Matasaburo Fukutomi
%
%   LAST UPDATE:    08/01/2022
%
%   USAGE:  ETE = e_transfer_entropy(v1, v2, bin1, bin2, delay)
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
%           ETE     effective transfer entropy
%           rTE     a vector including transfer entropy calculated 
%                   with randomized data
%

TE = transfer_entropy(v1, v2, bin1, bin2, delay);

rTE = zeros(niter, 1);

for ii = 1:niter
    rTE(ii) = transfer_entropy(v1, v2(randsample(length(v2), length(v2))), bin1, bin2, delay);
end

ETE = TE - mean(rTE);
rTE = rTE - mean(rTE);

end