n = 10000;
n_rep = 20;
qs = 2:2:20;
d = 1;
n_qs = length(qs);

rlts = zeros(n_qs, 2);

for ii = 1:n_qs
    TEs = zeros(n_qs, 1);
    for jj = 1:n_rep
        a1 = randn(n, 1);
        a2 = [randn(d, 1); a1((1:(end - d))) + randn(n - d, 1)];
        qa1 = quantile(a1, qs(ii));
        qa2 = quantile(a2, qs(ii));
        TEs(jj) = e_transfer_entropy(a2, a1, qa2, qa1, d, 20);
    end
    rlts(ii, 1) = mean(TEs);
    rlts(ii, 2) = std(TEs);
end