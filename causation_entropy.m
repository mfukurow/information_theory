function CSE = causation_entropy(datamat, bincell, delay)

%
%   causation_entropy.m
%       calculates causation entropy
%
%   AUTHOR: Matasaburo Fukutomi
%
%   LAST UPDATE:    07/29/2022    
%
%   USAGE:  CSE = causation_entropy(datamat, bincell, delay)
%
%   VARIABLES:
%       inputs
%           datamat a matrix including data
%                   the first colomn must include hypothetical effect
%                   the second colomn must include hypothetical cause
%           bincell a cell including binning
%                   the order must correspond to the order of colomn
%                   datamat
%           delay   a vector of time points for delay
%           
%

n_delay = length(delay);
max_delay = max(delay);
[n_row, n_col] = size(datamat);

if ~(n_col == length(bincell))
    error('number of colomn of datamat is different from the number of binning of bincell')
end

tsdata = zeros(n_row - max_delay, n_col * n_delay + 1);
tsdata(:, 1) = datamat((max_delay + 1):end, 1);
for ii = 1:n_col
    for jj = 1:n_delay
        tsdata(:, n_delay * (ii - 1) + jj + 1) = ...
            datamat((max_delay + 1 - delay(jj)):(end - delay(jj)), ii);
    end
end

data1 = tsdata;
data1(:, (n_delay + 2):(2 * n_delay + 1)) = [];
bincell1 = repmat(bincell(1), 1, n_delay + 1);
for ii = 3:n_col
    bincell1 = [bincell1, repmat(bincell(ii), 1, n_delay)];
end
H1 = entropyH(data1, bincell1);

data2 = tsdata;
data2(:, [1, (n_delay + 2):(2 * n_delay + 1)]) = [];
bincell2 = repmat(bincell(1), 1, n_delay);
for ii = 3:n_col
    bincell2 = [bincell2, repmat(bincell(ii), 1, n_delay)];
end
H2 = entropyH(data2, bincell2);

data3 = tsdata;
bincell3 = repmat(bincell(1), 1, n_delay + 1);
for ii = 2:n_col
    bincell3 = [bincell3, repmat(bincell(ii), 1, n_delay)];
end
H3 = entropyH(data3, bincell3);

data4 = tsdata;
data4(:, 1) = [];
bincell4 = repmat(bincell(1), 1, n_delay);
for ii = 2:n_col
    bincell4 = [bincell4, repmat(bincell(ii), 1, n_delay)];
end
H4 = entropyH(data4, bincell4);

CSE = H1 - H2 - H3 + H4;

end