function I = mutual_information(v1, v2, bin1, bin2)

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

[v1r, v1c] = size(v1);
[v2r, v2c] = size(v2);

if v1r < v1c
    v1 = v1';
end

if v2r < v2c
    v2 = v2';
end

Hx = entropyH(v1, bin1);
Hy = entropyH(v2, bin2);
Hxy = entropyH([v1, v2], {bin1, bin2});
I = Hx + Hy - Hxy;

end