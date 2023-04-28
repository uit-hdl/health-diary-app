function lme = load_model(navi)
% Function for loading the main model
model_dir = navi.paths.models;
model_file = fullfile(model_dir, "lme.mat");
load(model_file, 'lme');
end