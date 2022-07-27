function I = mutual_information(datamat, bincell)

%
%   mutual_information.m
%       calculates mutual information
%
%   AUTHOR: Matasaburo Fukutomi
%
%   LAST UPDATE:    07/27/2022
%
%   USAGE:  I = mutual_information(datamat, bincell)
%
%   VARIABLES:
%       inputs
%           datamat = a matrix containing data
%           bincell = a cell including vectors of binning
%       outputs
%           I = mutual information
%

Hx = entropyH(multi_hist(datamat(:, 1), bincell(1)));
Hy = entropyH(multi_hist(datamat(:, 2), bincell(2)));
Hxy = entropyH(multi_hist(datamat, bincell));
I = Hx + Hy - Hxy;

end