function TE = transfer_entropy(v1, v2, bin1, bin2, delay)

%
%   transfer_entropy.m
%       calculates transfer entropy (v2 -> v1)
%
%   AUTHOR: Matasaburo Fukutomi
%
%   LAST UPDATE:    07/27/2022
%
%   USAGE:  TE = transfer_entropy(v1, v2, bin1, bin2, delay)
%
%   VARIABLES:
%       inputs
%           v1 = a vector of process 1 (hypothetical effect)
%           v2 = a vector of process 2 (hypothetical cause)
%           bin1 = binning for v1
%           bin2 = binning for v2
%           delay = a vector of time points for delay
%       outputs
%           TE = transfer entropy
%

n_v1 = length(v1);
n_v2 = length(v2);
if ~(n_v1 == n_v2)
    error('length of v1 and v2 are different')
end

[v1r, v1c] = size(v1);
[v2r, v2c] = size(v2);

if v1r < v1c
    v1 = v1';
end

if v2r < v2c
    v2 = v2';
end

n_delay = length(delay);
max_delay = max(delay);

datav1 = zeros(n_v1 - max_delay, n_delay + 1);
datav1(:, 1) = v1((max_delay + 1):end);
for ii = 1:n_delay
    datav1(:, ii + 1) = v1((max_delay + 1 - delay(ii)):(end - delay(ii)));
end

datav2 = zeros(n_v2 - max_delay, n_delay + 1);
datav2(:, 1) = v2((max_delay + 1):end);
for ii = 1:n_delay
    datav2(:, ii + 1) = v2((max_delay + 1 - delay(ii)):(end - delay(ii)));
end

H1 = entropyH(datav1, repmat({bin1}, 1, n_delay + 1));
H2 = entropyH(datav1(:, 2:end), repmat({bin1}, 1, n_delay));
H3 = entropyH([datav1, datav2(:, 2:end)], ...
    [repmat({bin1}, 1, n_delay + 1), repmat({bin2}, 1, n_delay)]);
H4 = entropyH([datav1(:, 2:end), datav2(:, 2:end)], ...
    [repmat({bin1}, 1, n_delay), repmat({bin2}, 1, n_delay)]);
TE = H1 - H2 - H3 + H4;

end
