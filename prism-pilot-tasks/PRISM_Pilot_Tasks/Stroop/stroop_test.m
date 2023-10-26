function [ ] = stroop_test(subject,cond,test_type,test_timepoint,target_stim) 
% Modified Stroop task script to be used for the PRISM PILOT
% subject = string; ID assigned to subject
% cond = string; 'high' or 'low'
% test_type = string; 'prac' 'prac1' prac2'
% -or- 'expA' or 'expB' or 'expC' or 'expD' or 'expE' or 'expF'
% test_timepoint= 'pre' or 'post'
% target_stim = 'FPCNB' or 'DAN' or 'vertex'
%Keep the script open under and run it from here: C:/Users/cogne/Desktop/PRISM_Pilot_Tasks/Stroop
%Confirm data folder exists under this folder. Do not open it

cd '/Users/brian/Documents/PRISM_Pilot_Tasks/Stroop'

% --- Set up parameters --- %
block_seq = [1 2 1];

% Determine number of trials (nTrials)
if strcmp(test_type,'prac') || strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') || strcmp(test_type,'prac5')
    nTrials = 24;
elseif strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expE') || strcmp(test_type,'expF')
    nTrials = 144;
end

% Add data and image file directories

% --- Restrict keys --- %
% Start experiment = 't', red = 'v', green = 'b', yellow = 'n', blue = 'm',
% safe quit = 'escape' (script terminates but results are saved)
KbName('UnifyKeyNames');
if strcmp(test_type,'prac') || strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') || strcmp(test_type,'prac5')
    KbCheckList = [KbName('t'),KbName('v'),KbName('b'),KbName('n'),KbName('m'),KbName('escape')];
elseif strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expE') || strcmp(test_type,'expF')
    KbCheckList = [KbName('t'),KbName('v'),KbName('b'),KbName('n'),KbName('m'),KbName('escape')];
end
RestrictKeysForKbCheck(KbCheckList);

% --- Initialize variables --- %
black = 0;
if strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expE') || strcmp(test_type,'expF')
    fixblockDur = 5.0000; % Fixation block duration (sec)
elseif strcmp(test_type,'prac') || strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') || strcmp(test_type,'prac5')
    fixblockDur = 5.0000;
end
respDur = 1.9000; % Trial duration (sec)
fixDur = 0.1000; % Fixation between trials duration (sec)
imgFolder = 'images/';

% --- Open screen with instructions --- %
Screen('Preference', 'SkipSyncTests', 2);
[window, rect] = Screen(max(Screen('Screens')), 'OpenWindow', [], []);
Priority(MaxPriority(window));
Screen('TextSize', window,30);
Screen(window, 'FillRect', [191 191 191]);
Screen(window, 'Flip', 0);

% --- Assign coordinates for images --- %
X = rect(RectRight);
Y = rect(RectBottom);
pic_coords = [0 0 X Y];

% Create coordinates for fixation cross
fix_pts = [
    [1 1 1 1]*X/2 + [0 0 -20 20];
    [1 1 1 1]*Y/2 + [-20 20 0 0]];

% --- Load and decode images --- %
if strcmp(test_type,'prac') || strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') || strcmp(test_type,'prac5')
    intro = imread('images/intro_prac.TIF');
end
if strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expF') || strcmp(test_type,'expE')
    intro=imread('images/intro.TIF');
end

introimg = Screen('MakeTexture',window,intro);

Screen(window, 'DrawTexture', introimg, [], pic_coords(1,:));
Screen(window, 'Flip', 0);

% Obtain randomized order of images
trial_info = load(['items/stroop_items_' cond '_' test_type '.mat']);

% Decode trial images and assign values
trial_images = zeros(nTrials,1);
for i = 1:nTrials
    
    trial_images(i,1) = i; % Trial number
    imgname = char(trial_info.new_items(i,1)); % Trial image filename
    word = imgname(1); % Trial word
    
    switch word
        case {'r','g','y','b'}
            correct = imgname(2);
            lure = imgname(1);
        otherwise
            correct = imgname(2);
            lure = 0;
    end
        
        % Assign values for correct color
        if strcmp(correct,'r')
            correct = 1;
        elseif strcmp(correct,'g')
            correct = 2;
        elseif strcmp(correct,'y')
            correct = 3;
        elseif strcmp(correct,'b')
            correct = 4;
        end 
        
        % Assign values for lure color
        if strcmp(lure,'r')
            lure = 1;
        elseif strcmp(lure,'g')
            lure = 2;
        elseif strcmp(lure,'y')
            lure = 3;
        elseif strcmp(lure,'b')
            lure = 4;
        else
            lure = 0;
        end 
        
    % Store values    
    trial_images(i,3:4) = [correct lure];
    
    % Load trial image files and convert to textures
    P_c = imread(fullfile(imgFolder,char(trial_info.new_items(i,1))));
    trial_images(i,1) = [Screen('MakeTexture',window,P_c)];
    
end

% --- Set up blank storage matrices for data storage --- %
% Response data: Trial #, Key press, Reaction time, Correct?, Lured?
RESPONSE = [1:nTrials; zeros(4,nTrials)]';
% Trial timestamps from GetSecs
ONSETS = cell(nTrials,1);

% --- Begin experiment --- %
HideCursor;

while 1 % Wait to move forward from intro image
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('t'))==1
        WaitSecs(0.2);
        Screen(window, 'Flip',0);
        break
    end      
end

% Display scanner message
% if strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expE') || strcmp(test_type,'expF')
%     DrawFormattedText(window,'Waiting for the scanner!','center','center',black);
% else
    DrawFormattedText(window,'Waiting for the experimenter!','center','center',black);
% end
Screen(window, 'Flip',0);
while 1 % Wait to move forward from scanner message
    [~,~,keyCode] = KbCheck;
    if keyCode(KbName('t'))==1
        Screen(window, 'Flip',0);
        break
    end      
end

% Start timer
tic
taskStart = GetSecs;

% Main experimental loop
block = 0;
taskblock = 0;

try
    for blk = 1:length(block_seq)
    
    % Pick apart block sequence
    block_type = block_seq(blk);
    block = block + 1;
    
        % Determine how many task blocks are in block sequence
        if block_type == 1
        else
            block_type = 2;
            taskblock = taskblock + 1;
        end
    
        if block_type == 1

            % Display fixation crosshair         
            fixationStart = GetSecs;
            Screen(window, 'DrawLines', fix_pts, 2, black);
            Screen(window, 'Flip', fixationStart);

            while GetSecs<fixationStart+fixblockDur % Quit anytime with escape
                    [keyIsDown, secs, keyCode] = KbCheck;
                    assert(~keyCode(KbName('escape')),'Quit early!');
            end % Terminate entire loop, proceed to save

        else

            % Determine how many trials to run per task block
            firsttrial = 1+(15*(taskblock-1));
            lasttrial = firsttrial + (nTrials-1);

            % --- Begin trials --- %
            % For each trial, load image and save onset time; flip screen
            % for images; take responses from user; allow escape to quit at
            % any time until end of trial

            for i = firsttrial:lasttrial; 
                trialStart = GetSecs;

                % Load and display image
                Screen(window, 'DrawTexture', trial_images(i,1), [], pic_coords(1,:));
                Screen(window, 'Flip',trialStart);

                % Save trial timestamp 
                ONSETS(i,1)={num2str(trialStart)};

                % Display trial for max respDur secs; if response detected
                % earlier, save response and move on to next trial 
                while GetSecs<trialStart+respDur;
                    [keyIsDown, secs, keyCode] = KbCheck;
                    assert(~keyCode(KbName('escape')),'Quit early!');

                    % Determine what response user is giving
                    if keyIsDown
                        if RESPONSE(i,2)==0

                            % Determine expected and lure answers
                            expected_ans = trial_images(i,3);
                            lure_ans = trial_images(i,4);

                            if strcmp(test_type,'prac') || strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') || strcmp(test_type,'prac5')
                            % If user responds 'red'
                                if keyCode(KbName('v'))==1
                                    iscorrect = isequal(expected_ans,1); % Correct?
                                    islured =  isequal(lure_ans,1); % Lured?
                                    RESPONSE(i,2:5) = [1 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;  

                                % If user responds 'green'
                                elseif keyCode(KbName('b'))==1
                                    iscorrect = isequal(expected_ans,2); % Correct?
                                    islured =  isequal(lure_ans,2); % Lured?
                                    RESPONSE(i,2:5) = [2 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;

                                % If user responds 'yellow'   
                                elseif keyCode(KbName('n'))==1
                                    iscorrect = isequal(expected_ans,3); % Correct?
                                    islured =  isequal(lure_ans,3); % Lured?
                                    RESPONSE(i,2:5) = [3 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;

                                % If user responds 'blue'    
                                elseif keyCode(KbName('m'))==1
                                    iscorrect = isequal(expected_ans,4); % Correct?
                                    islured = isequal(lure_ans,4); % Lured? 
                                    RESPONSE(i,2:5) = [4 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;

                                end
                            elseif strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expE') || strcmp(test_type,'expF')
                                if keyCode(KbName('v'))==1
                                    iscorrect = isequal(expected_ans,1); % Correct?
                                    islured =  isequal(lure_ans,1); % Lured?
                                    RESPONSE(i,2:5) = [1 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;
                                    
                                    % If user responds 'green'
                                elseif keyCode(KbName('b'))==1
                                    iscorrect = isequal(expected_ans,2); % Correct?
                                    islured =  isequal(lure_ans,2); % Lured?
                                    RESPONSE(i,2:5) = [2 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;
                                    
                                    % If user responds 'yellow'
                                elseif keyCode(KbName('n'))==1
                                    iscorrect = isequal(expected_ans,3); % Correct?
                                    islured =  isequal(lure_ans,3); % Lured?
                                    RESPONSE(i,2:5) = [3 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;
                                    
                                    % If user responds 'blue'
                                elseif keyCode(KbName('m'))==1
                                    iscorrect = isequal(expected_ans,4); % Correct?
                                    islured = isequal(lure_ans,4); % Lured?
                                    RESPONSE(i,2:5) = [4 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;
                                    
                                end
                            end
                        end
                    end
                end 

                % Display small fixation between trials
                Screen(window, 'DrawLines', fix_pts, 2, [191 191 191]);
                Screen(window, 'Flip',trialStart+respDur);

                % Allow user to quit during small fixation between trials
                while GetSecs<trialStart+fixDur+respDur
                    [keyIsDown, secs, keyCode] = KbCheck;
                    assert(~keyCode(KbName('escape')),'Quit early!');
                end
                
            end
        end
    end

    
    disp('######## FINISHED NORMALLY ########')
    
catch % If any errors occur
    disp('######## QUIT EARLY ########')
    disp('Current item:')
    disp(i)
end 

% Compute total time  
toc

% --- Store and save data --- %
Screen('CloseAll');
ShowCursor; %show mouse

% Columns in data file: Trial #, Expected, Lure, Key Press, Response Time, 
% Correct?, Lured?, Eligible? 
final.data = [RESPONSE(:,1) trial_images(:,3:4) RESPONSE(:,2:5)];
for i = 1:nTrials;
    final.imagenames{i,1} = trial_info.new_items{i,1};
    final.ONSETS{i,1} = ONSETS{i,1};
end

% Determine whether trials contained a lure, i.e. eligible
if strcmp(cond,'high')
    eligible_index = ones(nTrials,1);
elseif strcmp(cond,'low')
    eligible_index = zeros(nTrials,1);
end
final.data = [final.data eligible_index(1:nTrials,1)];

% Column headers for data storage
final.datacolumnheaders =  [{'trialN'} {'expectedpress'} {'lurepress'} {'response'} {'RT'} {'correct'} {'lured'} {'eligible?'}];

% Prevent file overwrite
filename = ['data/' subject '_stroop_data_' cond '_' test_type '_' test_timepoint '_' target_stim '.mat'];
x = 1;
while exist(filename)==2
    x=x+1;
    filename = ['data/' subject '_stroop_data_' cond '_' test_type '_' test_timepoint '_' target_stim '-x' num2str(x) '.mat'];
end


% Save file
save(filename,'final');
disp('------>> SAVE SUCCESSFUL ')

end