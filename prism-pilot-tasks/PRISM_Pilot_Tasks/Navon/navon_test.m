function [ ]  = navon_test(subject,cond,test_type,first_color,test_timepoint,target_stim)
%Modified Navon task script to be used for the PRISM PILOT
% subject = string; ID assigned to subject
% cond = string; 'low' or 'high'
% test_type = string; 'prac' 'prac1' prac2' 'prac3' 'prac4' 'prac5'
% -or- 'expA' or 'expB' or 'expC' or 'expD' or 'expE' or 'expF'
% first_color = string; 'g' or 'w' for low condition, or 'na' for high
% test_timepoint=string; 'pre' or 'post' for the pre or post timepoint for
% target_stim = 'FPCNB' or 'DAN' or 'vertex'
%Keep the script open under and run it from here: C:/Users/cogne/Desktop/PRISM_Pilot_Tasks/Navon
%Confirm data folder exists under this folder. Do not open it

cd '/Users/brian/Documents/PRISM_Pilot_Tasks/Navon'

% --- Set up parameters --- % 
block_seq = [1 2 1];

% Determine number of trials (nTrials)
if strcmp(test_type,'prac') || strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') || strcmp(test_type,'prac5')
    nTrials= 24;
end

if strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expF') || strcmp(test_type,'expE')
        nTrials = 144;     %Total 5mins task; 1min fixation cross and 4 mins perform task
end

% Add data and image file directories
%addpath('/Users/lstclair/Documents/Navon/images');
%addpath('/Users/lstclair/Documents/Navon/data');

% --- Restrict keys --- %
% Start experiment = 't', red = 'r', green = 'g', yellow = 'y', blue = 'b',
% safe quit = 'escape' (script terminates but results are saved)
KbName('UnifyKeyNames');
if strcmp(test_type,'prac') || strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expF') || strcmp(test_type,'expE')
    KbCheckList = [KbName('t'),KbName('v'),KbName('b'),KbName('n'),KbName('m'),KbName('escape')];
elseif strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') ||strcmp(test_type,'prac5')
    KbCheckList = [KbName('t'),KbName('v'),KbName('b'),KbName('n'),KbName('m'),KbName('escape')];
end
RestrictKeysForKbCheck(KbCheckList);

% --- Initialize variables --- %
white = 255;
black = 0;
if strcmp(test_type,'expA') || strcmp(test_type,'expB') || strcmp(test_type,'expC') || strcmp(test_type,'expD') || strcmp(test_type,'expF') || strcmp(test_type,'expE')
    fixblockDur =5.0000; % Fixation block duration (sec)
elseif strcmp(test_type,'prac') || strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') ||strcmp(test_type,'prac5')
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
Screen('TextColor', window, [1 1 1]);
Screen(window, 'FillRect', black);

% --- Assign coordinates for images --- %
X = rect(RectRight);
Y = rect(RectBottom);
image = imread('images/lct.TIF');
[x,y,z] = size(image);
ratio = x/y;
x1 = round((0.5*(X-(ratio*X))));
x2 = round((X-(0.5*(X-(ratio*X)))));
pic_coords = [x1 0 x2 Y];

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

midpoint = imread('images/midpoint.TIF');
midpointimg = Screen('MakeTexture',window,midpoint);

Screen(window, 'DrawTexture', introimg, [], pic_coords(1,:));
Screen(window, 'Flip', 0);

% Obtain randomized order of images
if strcmp(cond,'low')
    trial_info=load(['items/navon_items_' cond '_' test_type '_' first_color '.mat']);
elseif strcmp(cond,'high')
    trial_info=load(['items/navon_items_' cond '_' test_type '.mat']);
end


% Decode trial images and assign values
trial_images = zeros(nTrials,4);
for i = 1:nTrials
    
    % Circle -> r
    % X -> g
    % Triangle -> y
    % Square -> b
    
    trial_images(i,1) = i; % Trial number
    imgname= char(trial_info.new_items(i,1)); % Trial image filename
    glob_loc = imgname(1); % Trial word

    % Determine whether trial is global or local
    if glob_loc == 'g'
        correct = imgname(2);
        lure = imgname(3);
    elseif glob_loc =='l'
        correct = imgname(3);
        lure = imgname(2);
    end

    % Assign values for correct shape
    if strcmp(correct,'c')
        correct = 1;
    elseif strcmp(correct,'x')
        correct = 2;
    elseif strcmp(correct,'t')
        correct = 3;
    elseif strcmp(correct,'s')
        correct = 4;
    end 

    % Assign values for lure shape
    if strcmp(lure,'c')
        lure = 1;
    elseif strcmp(lure,'x')
        lure = 2;
    elseif strcmp(lure,'t')
        lure = 3;
    elseif strcmp(lure,'s')
        lure = 4;
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
    [~,~,keyCode] = KbCheck(-1);
    if keyCode(KbName('t'))==1
        WaitSecs(0.2);
        Screen(window, 'Flip',0);
        break
    end      
end

% Display scanner message
if strcmp(test_type,'prac') || strcmp(test_type,'prac1') || strcmp(test_type,'prac2') || strcmp(test_type,'prac3') || strcmp(test_type,'prac4') ||strcmp(test_type,'prac5')
    DrawFormattedText(window,'Waiting for the experimenter!','center','center',white);
else
    DrawFormattedText(window,'Waiting for the experimenter for task!','center','center',white);
end
Screen(window, 'Flip',0);
while 1 % Wait to move forward from scanner message
    [~,~,keyCode] = KbCheck(-1);
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
    for blk = 1:length(block_seq);
    
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
            Screen(window, 'DrawLines', fix_pts, 2, white);
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
            % For reach trial, load image and save onset time; flip screen
            % for images; take responses from user; allow escape to quit at
            % any time until end of trial

            for i = firsttrial:lasttrial 
                
                if i == (nTrials/2)+1
                    if strcmp(cond,'low')
                        % Display midpoint switching cue
                        Screen(window, 'DrawTexture', midpointimg, [], pic_coords(1,:));
                        Screen(window, 'Flip', 0);
                        %while 1 % Wait to move forward from midpoint cue
                           % [~,~,keyCode] = KbCheck;
                          %  if keyCode(KbName('t'))==1
                          WaitSecs(5);
                                Screen(window, 'Flip',0);
                                %break
                            %end      
                       % end
                        % Display small fixation after midpoint cue
                        Screen(window, 'DrawLines', fix_pts, 2, black);
                        Screen(window, 'Flip',trialStart+respDur);
                    end
                end
                
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
                            
                                % If user responds 'circle'
                                if keyCode(KbName('v'))==1
                                    iscorrect = isequal(expected_ans,1); % Correct?
                                    islured =  isequal(lure_ans,1); % Lured? 
                                    RESPONSE(i,2:5) = [1 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;  

                                % If user responds 'x'
                                elseif keyCode(KbName('b'))==1
                                    iscorrect = isequal(expected_ans,2); % Correct?
                                    islured =  isequal(lure_ans,2); % Lured? 
                                    RESPONSE(i,2:5) = [2 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;

                                % If user responds 'triangle'
                                elseif keyCode(KbName('n'))==1
                                    iscorrect = isequal(expected_ans,3);
                                    islured =  isequal(lure_ans,3);
                                    RESPONSE(i,2:5) = [3 secs-trialStart iscorrect islured];
                                    KbEventFlush;

                                % If user responds 'square'
                                elseif keyCode(KbName('m'))==1
                                    iscorrect = isequal(expected_ans,4); % Correct?
                                    islured =  isequal(lure_ans,4); % Lured?
                                    RESPONSE(i,2:5) = [4 secs-trialStart iscorrect islured]; % Store response data
                                    KbEventFlush;
                                end
                        end
                    end
                end
            end
       
                
                % Display small fixation between trials
                Screen(window, 'DrawLines', fix_pts, 2, black);
                Screen(window, 'Flip',trialStart+respDur);
                
                % Allow user to quit during small fixation between trials
                while GetSecs<trialStart+fixDur+respDur
                    [keyIsDown, secs, keyCode] = KbCheck;
                    assert(~keyCode(KbName('escape')),'Quit early!');
                end

        end
    end
          
    
    disp('######## FINISHED NORMALLY ########')
    
catch
    disp('######## QUIT EARLY ########')   % If any errors occur
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

% Determine whether trials contained a switch
switches = zeros(nTrials,1);
for i = 1:nTrials
    switches(i,1) = trial_info.new_items{i,2};
end
final.data = [final.data switches(1:nTrials,1)];

% Column headers for data storage
final.datacolumnheaders =  [{'trialN'} {'expectedpress'} {'lurepress'} {'response'} {'RT'} {'correct'} {'lured'} {'switched?'}];

% Prevent file overwrite

    filename = ['data/' subject '_navon_data_' cond '_' test_type '_' first_color '_' test_timepoint '_' target_stim '.mat'];
    x = 1;
    while exist(filename)==2
        x=x+1;
        filename = ['data/' subject '_navon_data_' cond '_'  test_type '_' first_color '_' test_timepoint '_' target_stim '-x' num2str(x) '.mat'];
    end


% Save file
save(filename,'final');
disp('------>> SAVE SUCCESSFUL ')

end

