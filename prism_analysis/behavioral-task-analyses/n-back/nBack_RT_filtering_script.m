%% Reaction time filter script
% This code reads in the raw n-back data sheet and removes subjects who have
% reaction times over 0.200 secs and filters to only consider correct
% trials.
%% Read in n-Back data from experimental csv and filter by relevant data
nBackData = readtable('results_output/n-back_exp_results.csv');
nBackCorrectTrials = nBackData((nBackData.correct == 1),:);

% Filter for post data and only n-back trials using built-in table utils
rtFilteredNBack = nBackCorrectTrials((nBackCorrectTrials.rt >= 0.200),:);

%% Remove these rows from the excel sheet
outputForNewSheet = table2cell(rtFilteredNBack);

% Write to excel sheets
finalfilename = 'n-back_exp_results_RTfiltered.csv';
header = {'subject', 'n_back', 'trialN', 'blockN', 'rt', 'correct', 'trialType', 'stim_site', 'timepoint', 'counterbalance', 'sessionNum', 'days'};
outputForNewSheet = [header ; outputForNewSheet];
writecell(outputForNewSheet, finalfilename);