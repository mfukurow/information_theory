function H = entropyH(dat, bin)

%
%   entropyH.m
%       calculates Shannon's entropy
%
%   AUTHOR: Matasaburo Fukutomi
%   
%   LAST UPDATE:    07/27/2022
%
%   USAGE:  H = entropyH(prob, bin)
%
%   VARIABLES:
%       inputs
%           dat = a vector (or matrix) containing data
%                 each colomn includes each variable
%           bin = a vector of binning
%                 if dat includes multiple variables, set 
%                 the corresponding binning vectors in a 
%                 cell format
%       outputs
%           H = Shannon's entropy
%

if ~iscell(bin)
    bin = {bin};
end

prob = multi_hist(dat, bin);

prob(~prob) = [];
H = sum(-prob .* log2(prob));

end

function [prob, counts] = multi_hist(datamat, bincell)

%
%   multi_hist.m
%       makes a vector of probability density (or histogram counts)
%       
%   AUTHOR: Matasaburo Fukutomi
%
%   LAST UPDATE:    07/26/2022
%
%   USAGE:  [prob, counts] = multi_hist(datamat, bincell)
%
%   VARIABLES:
%       inputs
%           datamat = a matrix containing data
%           bincell = a cell including vectors of binning
%       outputs
%           prob = a vector of probability density
%           counts = a vector of count corresponding to 'prob'
%

ncol = size(datamat, 2);
if ncol ~= length(bincell)
    error('the size of datamat is different from the number of bincell')
end

for ii = 1:ncol
    if ii == 1
        symbols = symbolize(datamat(:, ii), bincell{ii});
    else
        symbols_ii = symbolize(datamat(:, ii), bincell{ii});
        symbols = append(symbols, symbols_ii);
    end
end

tbl = tabulate(symbols);
prob = cell2mat(tbl(:, 3)) / 100;
counts = cell2mat(tbl(:, 2)) / sum(cell2mat(tbl(:, 2)));

end

function symbolcell = symbolize(x, bin)

n_x = length(x);
n_bin = length(bin);
format_C = ['%0', num2str(ceil(log10(n_bin))), 'd'];
symbolcell = cell(n_x, 1);
symbolcell(:) = {num2str(0, format_C)};

for ii = 1:n_bin
    symbolcell(x > bin(ii)) = {num2str(ii, format_C)};
end

end
