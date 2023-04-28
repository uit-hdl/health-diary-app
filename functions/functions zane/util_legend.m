function util_legend(symbols, descriptions)

hold on
N_symbols = numel(symbols);
h = [];
for i = 1:N_symbols
    a = plot(nan, nan, symbols(i));
    h = [h;a];
end
legend(h, descriptions)

end