function CSE = causation_entropy(datamat, bincell, delay)

%
%   causation_entropy.m
%

n_delay = length(delay);
max_delay = max(delay);
n_col = size(datamat, 2);
eff = datamat((max_delay + 1):end, 1);



end