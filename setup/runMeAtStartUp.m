% Run this script to set up paths, and load and process data.

addPaths

% import long table
load('mat_info.mat', 'info')
navi.surveyInfo = info;

importLongData
renameVariablesOfInterest
