n = 10000;
d = 1;

a1 = randn(n, 1);
a2 = [randn(d, 1); a1((1:(end - d))) + randn(n - d, 1)];
a3 = randn(n, 1);

qa1 = quantile(a1, 9);
qa2 = quantile(a2, 9);
qa3 = quantile(a3, 9);

datamat = [a1, a2, a3];
bin_cell = {qa1, qa2, qa3};