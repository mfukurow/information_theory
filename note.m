n = 10000;
d = 1;

a1 = randn(n, 1);
a2 = [randn(d, 1); a1((1:(end - d))) + randn(n - d, 1)];

%%
qa1 = quantile(a1, 9);
qa2 = quantile(a2, 9);

%%
H1 = entropyH([a2(1:(end - 1)), a2(2:end)], repmat({qa2}, 1, 2));
H2 = entropyH(a2(1:(end - 1)), qa2);
H3 = entropyH([a2(1:(end - 1)), a2(2:end), a1(1:(end - 1))], [repmat({qa2}, 1, 2), {qa1}]);
H4 = entropyH([a2(1:(end - 1)), a1(1:(end - 1))], {qa2, qa1});
TE = H1 - H2 - H3 + H4;

%%
%{
H1 = entropyH(multi_hist([a1((1 + d):end), a1(1:(end - d))], {qa1, qa1}));
H2 = entropyH(multi_hist(a1(1:(end - d)), {qa1}));
H3 = entropyH(multi_hist([a1((1 + d):end), a1(1:(end - d)), a2(1:(end - d))], {qa1, qa1, qa2}));
H4 = entropyH(multi_hist([a1(1:(end - d)), a2(1:(end - d))], {qa1, qa2}));
H = H1 - H2 - H3 + H4;

%%
H1 = entropyH(multi_hist([a2((1 + d):end), a2(1:(end - d))], {qa2, qa2}));
H2 = entropyH(multi_hist(a2(1:(end - d)), {qa2}));
H3 = entropyH(multi_hist([a2((1 + d):end), a2(1:(end - d)), a1(1:(end - d))], {qa2, qa2, qa1}));
H4 = entropyH(multi_hist([a2(1:(end - d)), a1(1:(end - d))], {qa2, qa1}));
H = H1 - H2 - H3 + H4;
%}

%%
ax(1) = subplot(3, 3, 1:3);
plot(a1)
xlabel('x')
ylabel('Position')
title('a1')

ax(2) = subplot(3, 3, 4:6);
plot(a2)
xlabel('x')
ylabel('Position')
title('a2')

linkaxes(ax, 'x')

subplot(3, 3, 7)
plot(a1, a2, '.')
xlabel('a1(x)')
ylabel('a2(x)')

subplot(3, 3, 8)
plot(a1(1:(end - d)), a2((1 + d):end), '.')
xlabel('a1(x - 1)')
ylabel('a2(x)')

subplot(3, 3, 9)
plot(a1((1 + d):end), a2(1:(end - d)), '.')
xlabel('a1(x)')
ylabel('a2(x - 1)')

%%
qa1 = quantile(a1, 9);
qa2 = quantile(a2, 9);

%%
histogram(a1)
hold on
for ii = 1:length(qa1)
    xline(qa1(ii))
end
