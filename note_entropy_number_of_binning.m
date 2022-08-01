n = 10000;
n_rep = 100;
qs = 2:100;
n_qs = length(qs);

rlts = zeros(n_qs, 2);

for ii = 1:n_qs
    Hs = zeros(n_rep, 1);
    for jj = 1:n_rep
        data_jj = randn(n, 1);
        bin_jj = quantile(data_jj, qs(ii));
        Hs(jj) = entropyH(data_jj, bin_jj);
    end
    rlts(ii, 1) = mean(Hs);
    rlts(ii, 2) = std(Hs);
end

%%
plot(qs + 1, rlts(:, 1))
xlim([0 100])
xlabel('Number of binning')
ylabel('Entropy')
