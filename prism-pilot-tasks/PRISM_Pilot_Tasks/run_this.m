%% Call script from command line (do NOT press run)
%%In case the script stops running, run it manually
%Navon command example:
%navon_test('P_ASK','low','expF','g','pre','vertex')
%Stroop command example:
%stroop_test('P_ASK','high','expB','post','vertex')
cd '/Users/brian/Documents/PRISM_Pilot_Tasks'
raw=readcell('pilot_study_rand_subject_v2.xlsx');

%% Ask user for subject nmber and if the session is pre/post and number of session
prompt = {'Enter Subject ID','Enter Pre/Post:','Enter Session Number(1,2,3):'};
dlgtitle = 'Trial Info';
dims = [1 50];
definput = {'P_XXX','Pre','1'};
answer = string(inputdlg(prompt,dlgtitle,dims,definput));

check1 = questdlg('Please check data folders under Navon and Stroop to ensure there are no files with subjects ID','Check','Done','default');

%% Pull out the proper info from matrix
% Pulls out rows for just this subject
raw1=raw(3:end,:);
index=find(strcmp(raw1,answer(1,1)));
subject_matrix=raw1(index,:);
% Makes sure inputs are valid
if strcmp(answer(2,1),'Pre') + strcmp(answer(2,1),'Post') == 0
    disp(['Invalid Timepoint, either Pre or Post'])
    return;
end
if strcmp(answer(3,1),'1') + strcmp(answer(3,1),'2') +strcmp(answer(3,1),'3') == 0
    disp(['Invalid Session Number, either 1 or 2 or 3'])
    return;
end
subject_entered=find(strcmp(raw1,answer(1,1)));
% subject_entered=num2str(subject_entered);
if isempty(subject_entered)==1 
    disp(['Invalid Subject ID, check sheet'])
    return;
end


% Pulls out data
new_ans=str2double(answer(3,1));
sub_matrix=subject_matrix(new_ans,:);
subject=char(answer(1,1));
sub_matrix=string(sub_matrix);
first_color=char(sub_matrix(1,4));
target_stim=char(sub_matrix(1,3));

if strcmp(answer(2,1),'Pre')
    navonprac=sub_matrix(1,5:6);
    navonref_matrix=sub_matrix(1,7:8);
    nbackprac=sub_matrix(1,11);
    nbackref_matrix=sub_matrix(1,12);
    stroopprac=sub_matrix(1,14:15);
    stroopref_matrix=sub_matrix(1,16:17);
    test_timepoint='Pre';
elseif strcmp(answer(2,1),'Post')
    navonref_matrix=sub_matrix(1,9:10);
    nbackref_matrix=sub_matrix(1,13);
    stroopref_matrix=sub_matrix(1,18:19);
    test_timepoint='Post';
end

%% Low practice Navon
if strcmp(test_timepoint,'Pre')==1
    cd '/Users/brian/Documents/PRISM_Pilot_Tasks/Navon'
    navonprac=string(navonprac);
    sub_matrix=string(sub_matrix);
    subject=char(answer(1,1));
    test_type=char(navonprac(1,1));
    first_color=char(sub_matrix(1,4));
    target_stim=char(sub_matrix(1,3));
    popupname=[subject ', ' test_timepoint ', ' target_stim ', ' first_color ', ' test_type];
    answer = questdlg(popupname,'Low Navon Prac','Correct','Incorrect','default');
    switch answer
        case 'Incorrect'
            disp(['Wrong Inputs'])
            return;
    end
    navon_test(subject,'low',test_type,first_color,test_timepoint,target_stim)
    trialin=load(['data/' subject '_navon_data_low' '_' test_type '_' first_color '_' test_timepoint '_' target_stim '.mat']);
    if sum(trialin.final.data(:,6))/24 >= .50
        display=string(sum(trialin.final.data(:,6)));
        stringforbox=append('Number Correct: ', display, '/24');
        questdlg(stringforbox, 'Low Navon Prac','OK','default');
    else
        display=string(sum(trialin.final.data(:,6)));
        stringforbox=append('Number Correct: ', display, '/24, Redo Practice');
        questdlg(stringforbox, 'Low Navon Prac','OK','default');  
        navon_test(subject,'low',test_type,first_color,test_timepoint,target_stim)
        trialin=load(['data/' subject '_navon_data_low' '_' test_type '_' first_color '_' test_timepoint '_' target_stim '-x2.mat']);
        if sum(trialin.final.data(:,6))/24 >= .50
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24');
            questdlg(stringforbox, 'Low Navon Prac','OK','default');  
        else
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24, Redo Practice');
            questdlg(stringforbox, 'Low Navon Prac','OK','default');  
            navon_test(subject,'low',test_type,first_color,test_timepoint,target_stim)
            trialin=load(['data/' subject '_navon_data_low' '_' test_type '_' first_color '_' test_timepoint '_' target_stim '-x3.mat']);
            display=string(sum(trialin.final.data(:,6)));
            stringforbox =append('Number Correct: ', display, '/24, Move on');
            questdlg(stringforbox, 'Low Navon Prac','OK','default');  
        end
    end 
end


%% High practice Navon
if strcmp(test_timepoint,'Pre')==1
    test_type=char(navonprac(1,2));
    popupname=[subject ', ' test_timepoint ', ' target_stim ', ' first_color ', ' test_type];
    answer = questdlg(popupname,'High Navon Prac','Correct','Incorrect','default');
    switch answer
        case 'Incorrect'
            disp(['Wrong Inputs'])
            return;
    end
    navon_test(subject,'high',test_type,first_color,test_timepoint,target_stim);
    trialin=load(['data/' subject '_navon_data_high' '_' test_type '_' first_color '_' test_timepoint '_' target_stim '.mat']);
    if sum(trialin.final.data(:,6))/24 >= .50
        display=string(sum(trialin.final.data(:,6)));
        stringforbox=append('Number Correct: ', display, '/24');
        questdlg(stringforbox, 'High Navon Prac','OK','default');  
    else
        display=string(sum(trialin.final.data(:,6)));
        stringforbox=append('Number Correct: ', display, '/24, Redo Practice');
        questdlg(stringforbox, 'High Navon Prac','OK','default');    
        navon_test(subject,'high',test_type,first_color,test_timepoint,target_stim)
        trialin=load(['data/' subject '_navon_data_high' '_' test_type '_' first_color '_' test_timepoint '_' target_stim '-x2.mat']);
        if sum(trialin.final.data(:,6))/24 >= .50
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24');
            questdlg(stringforbox, 'High Navon Prac','OK','default');    
        else
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24, Redo Practice');
            questdlg(stringforbox, 'High Navon Prac','OK','default');    
            navon_test(subject,'high',test_type,first_color,test_timepoint,target_stim)
            trialin=load(['data/' subject '_navon_data_high' '_' test_type '_' first_color '_' test_timepoint '_' target_stim '-x3.mat']);
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24, Move on');
            questdlg(stringforbox, 'High Navon Prac','OK','default');   
        end
    end 
end
%% Practice n-back
if strcmp(test_timepoint,'Pre')==1
    answer = questdlg('Notify experimenter to switch to next task','N-back Practice','Done with n-back','default');
end

%% Low practice Stroop
if strcmp(test_timepoint,'Pre')==1
    cd '/Users/brian/Documents/PRISM_Pilot_Tasks/Stroop'
    stroopprac=string(stroopprac);
    test_type=char(stroopprac(1,1));
    popupname=[subject ', ' test_timepoint ', ' target_stim ', ' test_type];
    answer = questdlg(popupname,'Low Stroop Prac','Correct','Incorrect','default');
    switch answer
        case 'Incorrect'
            disp(['Wrong Inputs'])
            return;
    end
    stroop_test(subject,'low',test_type,test_timepoint,target_stim)
    trialin=load(['data/' subject '_stroop_data_low' '_' test_type '_' test_timepoint '_' target_stim '.mat']);
    if sum(trialin.final.data(:,6))/24 >= .50
        display=string(sum(trialin.final.data(:,6)));
        stringforbox=append('Number Correct: ', display, '/24');
        questdlg(stringforbox, 'Low Stroop Prac','OK','default');
    else
        display=string(sum(trialin.final.data(:,6)));
        stringforbox=append('Number Correct: ', display, '/24, Redo Practice');
        questdlg(stringforbox, 'Low Stroop Prac','OK','default');
        stroop_test(subject,'low',test_type,test_timepoint,target_stim)
        trialin=load(['data/' subject '_stroop_data_low' '_' test_type '_' test_timepoint '_' target_stim '-x2.mat']);
        if sum(trialin.final.data(:,6))/24 >= .50
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24');
            questdlg(stringforbox, 'Low Stroop Prac','OK','default');
        else
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24, Redo Practice');
            questdlg(stringforbox, 'Low Stroop Prac','OK','default');
            stroop_test(subject,'low',test_type,test_timepoint,target_stim)
            trialin=load(['data/' subject '_stroop_data_low' '_' test_type '_' test_timepoint '_' target_stim '-x3.mat']);
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24, Move on');
            questdlg(stringforbox, 'Low Stroop Prac','OK','default');
        end
    end 
end


%% High practice Stroop
if strcmp(test_timepoint,'Pre')==1
    cd '/Users/brian/Documents/PRISM_Pilot_Tasks/Stroop'
    test_type=char(stroopprac(1,2));
    popupname=[subject ', ' test_timepoint ', ' target_stim ', ' test_type];
    answer = questdlg(popupname,'High Stroop Prac','Correct','Incorrect','default');
    switch answer
        case 'Incorrect'
            disp(['Wrong Inputs'])
            return;
    end
    stroop_test(subject,'high',test_type,test_timepoint,target_stim);
    trialin=load(['data/' subject '_stroop_data_high' '_' test_type '_' test_timepoint '_' target_stim '.mat']);
    if sum(trialin.final.data(:,6))/24 >= .50
        display=string(sum(trialin.final.data(:,6)));
        stringforbox=append('Number Correct: ', display, '/24');
        questdlg(stringforbox, 'High Stroop Prac','OK','default');
    else
        display=string(sum(trialin.final.data(:,6)));
        stringforbox=append('Number Correct: ', display, '/24, Redo Practice');
        questdlg(stringforbox, 'High Stroop Prac','OK','default');
        stroop_test(subject,'high',test_type,test_timepoint,target_stim)
        trialin=load(['data/' subject '_stroop_data_high' '_' test_type '_' test_timepoint '_' target_stim '-x2.mat']);
        if sum(trialin.final.data(:,6))/24 >= .50
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24');
            questdlg(stringforbox, 'High Stroop Prac','OK','default');
        else
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24, Redo Practice');
            questdlg(stringforbox, 'High Stroop Prac','OK','default');
            stroop_test(subject,'high',test_type,test_timepoint,target_stim)
            trialin=load(['data/' subject '_stroop_data_high' '_' test_type '_' test_timepoint '_' target_stim '_-x3.mat']);
            display=string(sum(trialin.final.data(:,6)));
            stringforbox=append('Number Correct: ', display, '/24, Move on');
            questdlg(stringforbox, 'High Stroop Prac','OK','default');
        end
    end 
end

%% Switch from Practice to Real Experiment
if strcmp(test_timepoint,'Pre')==1
    white = 255;
    black = 0;
    block_seq = [1 2 1];
    Screen('Preference', 'SkipSyncTests', 2);
    [window, rect] = Screen(max(Screen('Screens')), 'OpenWindow', [], []);
    Priority(MaxPriority(window));
    Screen('TextSize', window,30);
    Screen('TextColor', window, [1 1 1]);
    Screen(window, 'FillRect', black);
    DrawFormattedText(window,'Finished Practice, Wait for the experimenter to begin tasks!','center','center',white);
    Screen(window, 'Flip',0);
    while 1 % Wait to move forward from scanner message
        [~,~,keyCode] = KbCheck(-1);
        if keyCode(KbName('t'))==1
            Screen(window, 'Flip',0);
            break
        end
    end
    Screen('CloseAll');
end
%% Navon Low
cd '/Users/brian/Documents/PRISM_Pilot_Tasks/Navon'
test_type=char(navonref_matrix(1,1));
    popupname=[subject ', ' test_timepoint ', ' target_stim ', ' first_color ', ' test_type];
    answer = questdlg(popupname,'Low Navon','Correct','Incorrect','default');
    switch answer
        case 'Incorrect'
            disp(['Wrong Inputs'])
            return;
    end
navon_test(subject,'low',test_type,first_color,test_timepoint,target_stim)
%% Navon High
test_type=char(navonref_matrix(1,2));
    popupname=[subject ', ' test_timepoint ', ' target_stim ', ' first_color ', ' test_type];
    answer = questdlg(popupname,'High Navon','Correct','Incorrect','default');
    switch answer
        case 'Incorrect'
            disp(['Wrong Inputs'])
            return;
    end
navon_test(subject,'high',test_type,first_color,test_timepoint,target_stim)
%% N-back

answer = questdlg('Notify experimenter to switch to next task','N-back','Done with n-back','default');

%% Stroop Low
cd '/Users/brian/Documents/PRISM_Pilot_Tasks/Stroop'
test_type=char(stroopref_matrix(1,1));
    popupname=[subject ', ' test_timepoint ', ' target_stim ', ' first_color ', ' test_type];
    answer = questdlg(popupname,'Low Stroop','Correct','Incorrect','default');
    switch answer
        case 'Incorrect'
            disp(['Wrong Inputs'])
            return;
    end
stroop_test(subject,'low',test_type,test_timepoint,target_stim)
%% Stroop High
test_type=char(stroopref_matrix(1,2));
    popupname=[subject ', ' test_timepoint ', ' target_stim ', ' first_color ', ' test_type];
    answer = questdlg(popupname,'High Stroop','Correct','Incorrect','default');
    switch answer
        case 'Incorrect'
            disp(['Wrong Inputs'])
            return;
    end
stroop_test(subject,'high',test_type,test_timepoint,target_stim)