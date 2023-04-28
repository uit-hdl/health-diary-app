% Script for adding paths

filePath = matlab.desktop.editor.getActiveFilename;
projectRoot = fileparts(fileparts(fileparts(filePath)));

clear navi
navi.paths.project = projectRoot;
navi.paths.src = fullfile(navi.paths.project, 'src');

% Add most important folders to path
navi.paths.functions = fullfile(navi.paths.src, 'functions');
navi.paths.setup = fullfile(navi.paths.src, 'setup');
navi.paths.prototype = fullfile(navi.paths.src, 'prototype');
navi.paths.article = fullfile(navi.paths.src, '¤¤ article');

navi.paths.data = fullfile(navi.paths.project, 'data');
navi.paths.models = fullfile(navi.paths.project, 'saved matlab files', 'models');
navi.paths.generalFcns = fullfile(navi.paths.project, 'functions');
navi.paths.matlabFiles = fullfile(navi.paths.project, 'saved matlab files');

addpath( ...
    genpath(navi.paths.functions), ...
    genpath(navi.paths.setup), ...
    genpath(navi.paths.prototype), ...
    genpath(navi.paths.article), ...
    genpath(navi.paths.generalFcns), ...
    genpath(navi.paths.matlabFiles))