% Bootstrapping confidence intervals.

N = 1000;
srh_random_gen = zeros(N, 1);
for i=1:N
    srh_random_gen(i) = lme.random(D(end, :));
end

n_boot = 500;
boot_fun = @(x) std(x);
ci = bootci(n_boot, boot_fun, srh_random_gen)
ci_width = (ci(2) - ci(1))/2
T = array2table( ...
    [std(srh_random_gen), ...
    ci_width, ...
    std(lme.residuals, 'omitnan'), ...
    std(lme.randomEffects, 'omitnan'), ...
    std(lme.randomEffects, 'omitnan')], ...
    "VariableNames", ["std_random_sample", "SE", "std_e", "std_intercepts", "std_e + std_intercepts"])


std(lme.randomEffects)


sigma = std(lme.predict(D) - lme.response, 'omitnan');


mu_bobba = lme.predict(bobba);
bobba.age = 3.5
T_user = bobba;
T_user.hii = 0
mu_new = lme.predict(T_user);


% Probability of good or very good SRH
P_good_bobba = 1 - normcdf(2.5, mu_bobba, sigma)
P_good_new = 1 - normcdf(2.5, mu_new, sigma)


sqrt(0.47068^2 + 0.42175^2)


%%
close all
qqplot(lme.residuals)