#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v2020.2.5),
    on June 21, 2021, at 05:31
If you publish work using this script the most relevant publication is:

    Peirce J, Gray JR, Simpson S, MacAskill M, Höchenberger R, Sogo H, Kastman E, Lindeløv JK. (2019) 
        PsychoPy2: Experiments in behavior made easy Behav Res 51: 195. 
        https://doi.org/10.3758/s13428-018-01193-y

"""

from __future__ import absolute_import, division

from psychopy import locale_setup
from psychopy import prefs
from psychopy import sound, gui, visual, core, data, event, logging, clock, parallel
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)

import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle
import os  # handy system and path functions
import sys  # to get file system encoding

from psychopy.hardware import keyboard

key1 = 'right arrow'
key2 = 'left arrow'
sessOrder = []
trialList = []
n = 0


# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)

# Store info about the experiment session
psychopyVersion = '2020.2.5'
expName = 'nBack_exp_v2'  # from the Builder filename that created this script
expInfo = {'participant': '', 'session': ''}
dlg = gui.DlgFromDict(dictionary=expInfo, sort_keys=False, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['participant'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='C:\\Users\\CogNeW\\Desktop\\nBack\\nBack_exp_v2_lastrun.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.DEBUG)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp
frameTolerance = 0.001  # how close to onset before 'same' frame

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=[1920, 1080], fullscr=True, screen=0, 
    winType='pyglet', allowGUI=True, allowStencil=False,
    monitor='testMonitor', color=[0.137,0.137,0.137], colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='height')
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard()

# Initialize components for Routine "Experiment_Instructions_0back"
Experiment_Instructions_0backClock = core.Clock()
text_3 = visual.TextStim(win=win, name='text_3',
    text="This is an experimental block for the "  + str(n) + "-back task.  Whenever you see the letter X press the " + str(key1) + " key (upper or lower case). Otherwise, press the the " + str(key2) + " key. The letters will flash briefly on screen and you may respond even after the letter disappears during the '+'. Press the 'spacebar' to begin the task.",
    font='Arial',
    pos=(0, 0), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
key_resp_6 = keyboard.Keyboard()

# Initialize components for Routine "warmUpPulse"
warmUpPulseClock = core.Clock()
warmUp = parallel.ParallelPort(address='0xCFF8')

# Initialize components for Routine "fixation_2"
fixation_2Clock = core.Clock()
fixation_start = visual.TextStim(win=win, name='fixation_start',
    text='+',
    font='Arial',
    pos=(0, 0), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "trial_0back"
trial_0backClock = core.Clock()
from random import choice
import string
import time

lettersShown = []
allLetters = ['B', 'C', 'D', 'G', 'P', 'T', 'F', 'N', 'L']
targetLetter = 'X'
trialCount = 0

from psychopy import parallel
respPort = parallel.ParallelPort(address = 0xCFF8)
fixation = visual.TextStim(win=win, name='fixation',
    text='+',
    font='Arial',
    pos=(0, 0), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
letter_0back = visual.TextStim(win=win, name='letter_0back',
    text='default text',
    font='Arial',
    pos=(0, 0), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);
key_resp_5 = keyboard.Keyboard()
stimPort = parallel.ParallelPort(address='0xCFF8')

# Initialize components for Routine "transitionSlide"
transitionSlideClock = core.Clock()
trialInstruct = 1
trialInstruct2 = ''
text_7 = visual.TextStim(win=win, name='text_7',
    text='default text',
    font='Arial',
    pos=(0, 0), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
key_resp_11 = keyboard.Keyboard()

# Initialize components for Routine "Experimental_Instructions_nback"
Experimental_Instructions_nbackClock = core.Clock()
expInstructions = visual.TextStim(win=win, name='expInstructions',
    text='default text',
    font='Arial',
    pos=(0, 0), height=0.06, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
key_resp_3 = keyboard.Keyboard()

# Initialize components for Routine "fixation_2"
fixation_2Clock = core.Clock()
fixation_start = visual.TextStim(win=win, name='fixation_start',
    text='+',
    font='Arial',
    pos=(0, 0), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "trial_nback_2"
trial_nback_2Clock = core.Clock()
from random import choice
import string
import numpy as np

lettersShown = []
allLetters = ['B', 'C', 'D', 'G', 'P', 'T', 'F', 'N', 'L']
trialCount = 0

from psychopy import parallel
respPortn = parallel.ParallelPort(address = 0xCFF8)
letter = visual.TextStim(win=win, name='letter',
    text='default text',
    font='Arial',
    pos=(0, 0), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
key_resp_2 = keyboard.Keyboard()
stimPortn = parallel.ParallelPort(address='0xCFF8')
text_6 = visual.TextStim(win=win, name='text_6',
    text='+',
    font='Arial',
    pos=(0, 0), height=0.08, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "endStudy"
endStudyClock = core.Clock()
text = visual.TextStim(win=win, name='text',
    text='The study is over. Thank you!',
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# set up handler to look after randomisation of conditions etc
trials_7 = data.TrialHandler(nReps=1, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('zeroBackBlocks.xlsx'),
    seed=None, name='trials_7')
thisExp.addLoop(trials_7)  # add the loop to the experiment
thisTrial_7 = trials_7.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrial_7.rgb)
if thisTrial_7 != None:
    for paramName in thisTrial_7:
        exec('{} = thisTrial_7[paramName]'.format(paramName))

for thisTrial_7 in trials_7:
    currentLoop = trials_7
    # abbreviate parameter names if possible (e.g. rgb = thisTrial_7.rgb)
    if thisTrial_7 != None:
        for paramName in thisTrial_7:
            exec('{} = thisTrial_7[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "Experiment_Instructions_0back"-------
    continueRoutine = True
    # update component parameters for each repeat
    # usually we would use a conditions file to specify the number of nBack trials
    # but we want to ensure the position of the first n-Back trial
    # adapts to the requested n. i.e. if this is a 4-back trial
    # we cannot present an n-Back trial in the first 3 trials
    
    # what is the n (e.g. n = 2 "remember if this item is the same as 2 back")
    n = 0
    # how many trials in total?
    totalTrials = 1
    # how many n-Back trials?
    nBackTrials = 6
    # how many blocks?
    blocks = 4
    # make a list of trials; 0 = not nBack; 1 = nBack trial
    #trialList = [0]*(totalTrials-nBackTrials)+[1]*nBackTrials
    
    # buffer trials = first set of trials where an n-back trial cannot be presented
    #bufferTrials = trialList[:n]
    
    # experimental trials - include nBack trials
    #experimentalTrials = trialList[n:]
    
    # randomise the experimental trials
    #shuffle(experimentalTrials)
    
    # combine the buffer trials and experimental trials to make the final trialList
    #trialList = bufferTrials+experimentalTrials
    list1 =[0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0]
    list2 = [0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
    list3 = [1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1]
    list4 = [0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1]
    
    trialOrder1 = [list1, list2, list3, list4]
    trialOrder2 = [list2, list3, list4, list1]
    trialOrder3 = [list3, list4, list1, list2]
    trialOrder4 = [list4, list1, list2, list3]
    
    if expInfo['session'] == '1':
        sessOrder = trialOrder1
    elif expInfo['session'] == '2':
        sessOrder = trialOrder2
    elif expInfo['session'] == '3':
        sessOrder = trialOrder3
    elif expInfo['session'] == '4':
        sessOrder = trialOrder4
    
    ele = trials_7.thisRepN
    if ele < blocks:
        trialList = sessOrder[ele]
    
    key_resp_6.keys = []
    key_resp_6.rt = []
    _key_resp_6_allKeys = []
    # keep track of which components have finished
    Experiment_Instructions_0backComponents = [text_3, key_resp_6]
    for thisComponent in Experiment_Instructions_0backComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    Experiment_Instructions_0backClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "Experiment_Instructions_0back"-------
    while continueRoutine:
        # get current time
        t = Experiment_Instructions_0backClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=Experiment_Instructions_0backClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *text_3* updates
        if text_3.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            text_3.frameNStart = frameN  # exact frame index
            text_3.tStart = t  # local t and not account for scr refresh
            text_3.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(text_3, 'tStartRefresh')  # time at next scr refresh
            text_3.setAutoDraw(True)
        
        # *key_resp_6* updates
        waitOnFlip = False
        if key_resp_6.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            key_resp_6.frameNStart = frameN  # exact frame index
            key_resp_6.tStart = t  # local t and not account for scr refresh
            key_resp_6.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(key_resp_6, 'tStartRefresh')  # time at next scr refresh
            key_resp_6.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(key_resp_6.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(key_resp_6.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if key_resp_6.status == STARTED and not waitOnFlip:
            theseKeys = key_resp_6.getKeys(keyList=['space'], waitRelease=False)
            _key_resp_6_allKeys.extend(theseKeys)
            if len(_key_resp_6_allKeys):
                key_resp_6.keys = _key_resp_6_allKeys[-1].name  # just the last key pressed
                key_resp_6.rt = _key_resp_6_allKeys[-1].rt
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in Experiment_Instructions_0backComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "Experiment_Instructions_0back"-------
    for thisComponent in Experiment_Instructions_0backComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trials_7.addData('text_3.started', text_3.tStartRefresh)
    trials_7.addData('text_3.stopped', text_3.tStopRefresh)
    # the Routine "Experiment_Instructions_0back" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "warmUpPulse"-------
    continueRoutine = True
    routineTimer.add(0.400000)
    # update component parameters for each repeat
    if trials_7.thisN == 0:
        continueRoutine = True
    else:
        continueRoutine = False
    # keep track of which components have finished
    warmUpPulseComponents = [warmUp]
    for thisComponent in warmUpPulseComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    warmUpPulseClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "warmUpPulse"-------
    while continueRoutine and routineTimer.getTime() > 0:
        # get current time
        t = warmUpPulseClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=warmUpPulseClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        # *warmUp* updates
        if warmUp.status == NOT_STARTED and t >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            warmUp.frameNStart = frameN  # exact frame index
            warmUp.tStart = t  # local t and not account for scr refresh
            warmUp.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(warmUp, 'tStartRefresh')  # time at next scr refresh
            warmUp.status = STARTED
            win.callOnFlip(warmUp.setData, int(255))
        if warmUp.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > warmUp.tStartRefresh + .4-frameTolerance:
                # keep track of stop time/frame for later
                warmUp.tStop = t  # not accounting for scr refresh
                warmUp.frameNStop = frameN  # exact frame index
                win.timeOnFlip(warmUp, 'tStopRefresh')  # time at next scr refresh
                warmUp.status = FINISHED
                win.callOnFlip(warmUp.setData, int(0))
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in warmUpPulseComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "warmUpPulse"-------
    for thisComponent in warmUpPulseComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    if warmUp.status == STARTED:
        win.callOnFlip(warmUp.setData, int(0))
    trials_7.addData('warmUp.started', warmUp.tStart)
    trials_7.addData('warmUp.stopped', warmUp.tStop)
    
    # ------Prepare to start Routine "fixation_2"-------
    continueRoutine = True
    routineTimer.add(2.000000)
    # update component parameters for each repeat
    # keep track of which components have finished
    fixation_2Components = [fixation_start]
    for thisComponent in fixation_2Components:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    fixation_2Clock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "fixation_2"-------
    while continueRoutine and routineTimer.getTime() > 0:
        # get current time
        t = fixation_2Clock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=fixation_2Clock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *fixation_start* updates
        if fixation_start.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            fixation_start.frameNStart = frameN  # exact frame index
            fixation_start.tStart = t  # local t and not account for scr refresh
            fixation_start.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(fixation_start, 'tStartRefresh')  # time at next scr refresh
            fixation_start.setAutoDraw(True)
        if fixation_start.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > fixation_start.tStartRefresh + 2-frameTolerance:
                # keep track of stop time/frame for later
                fixation_start.tStop = t  # not accounting for scr refresh
                fixation_start.frameNStop = frameN  # exact frame index
                win.timeOnFlip(fixation_start, 'tStopRefresh')  # time at next scr refresh
                fixation_start.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in fixation_2Components:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "fixation_2"-------
    for thisComponent in fixation_2Components:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trials_7.addData('fixation_start.started', fixation_start.tStartRefresh)
    trials_7.addData('fixation_start.stopped', fixation_start.tStopRefresh)
    
    # set up handler to look after randomisation of conditions etc
    trials = data.TrialHandler(nReps=totalTrials, method='random', 
        extraInfo=expInfo, originPath=-1,
        trialList=[None],
        seed=None, name='trials')
    thisExp.addLoop(trials)  # add the loop to the experiment
    thisTrial = trials.trialList[0]  # so we can initialise stimuli with some values
    # abbreviate parameter names if possible (e.g. rgb = thisTrial.rgb)
    if thisTrial != None:
        for paramName in thisTrial:
            exec('{} = thisTrial[paramName]'.format(paramName))
    
    for thisTrial in trials:
        currentLoop = trials
        # abbreviate parameter names if possible (e.g. rgb = thisTrial.rgb)
        if thisTrial != None:
            for paramName in thisTrial:
                exec('{} = thisTrial[paramName]'.format(paramName))
        
        # ------Prepare to start Routine "trial_0back"-------
        continueRoutine = True
        routineTimer.add(2.500000)
        # update component parameters for each repeat
        thisTrialType = trialList[trialCount]
        thisLetter = "0"
        letterSet = allLetters
        
        flag = 0
        pulse_sent = False
        respPort.setData(0)
        pulse_terminated = True
        
        
        if thisTrialType == 0 : # not an n-back trial
            shuffle(letterSet)
            thisLetter = letterSet[-1]
        elif thisTrialType ==1: # an n-back trial
            thisLetter = targetLetter
        
        
        lettersShown.append(thisLetter)
        trials.addData('trialCount', trialCount)
        trials.addData('itemPresented', thisLetter)
        trials.addData('trialType', thisTrialType)
        
        
        if thisTrialType == 1:
            correct = 'right'
        else:
            correct = 'left'
        letter_0back.setText(thisLetter.join(choice((str.upper, str.lower))(c) for c in thisLetter)
)
        key_resp_5.keys = []
        key_resp_5.rt = []
        _key_resp_5_allKeys = []
        # keep track of which components have finished
        trial_0backComponents = [fixation, letter_0back, key_resp_5, stimPort]
        for thisComponent in trial_0backComponents:
            thisComponent.tStart = None
            thisComponent.tStop = None
            thisComponent.tStartRefresh = None
            thisComponent.tStopRefresh = None
            if hasattr(thisComponent, 'status'):
                thisComponent.status = NOT_STARTED
        # reset timers
        t = 0
        _timeToFirstFrame = win.getFutureFlipTime(clock="now")
        trial_0backClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
        frameN = -1
        
        # -------Run Routine "trial_0back"-------
        while continueRoutine and routineTimer.getTime() > 0:
            # get current time
            t = trial_0backClock.getTime()
            tThisFlip = win.getFutureFlipTime(clock=trial_0backClock)
            tThisFlipGlobal = win.getFutureFlipTime(clock=None)
            frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
            # update/draw components on each frame
            if key_resp_5.status == STARTED and flag == 0:
                if key_resp_5.keys == 'right' or key_resp_5.keys == 'left':
                    pulse_start_time = t
                    pulse_sent = True
                    pulse_terminate = False
                    respPort.setData(255)
                    time.sleep(.05)
                    respPort.setData(0)
                    flag = 1
                    
                        
            
            
            #if pulse_sent and not pulse_terminate:
            #    if t - pulse_start_time >= .004:
            #        p_port_6_setData(0)
            #        pulse_terminate = True
            #        pulse_sent = False
            #        
            
            # *fixation* updates
            if fixation.status == NOT_STARTED and tThisFlip >= 0.5-frameTolerance:
                # keep track of start time/frame for later
                fixation.frameNStart = frameN  # exact frame index
                fixation.tStart = t  # local t and not account for scr refresh
                fixation.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(fixation, 'tStartRefresh')  # time at next scr refresh
                fixation.setAutoDraw(True)
            if fixation.status == STARTED:
                # is it time to stop? (based on global clock, using actual start)
                if tThisFlipGlobal > fixation.tStartRefresh + 2-frameTolerance:
                    # keep track of stop time/frame for later
                    fixation.tStop = t  # not accounting for scr refresh
                    fixation.frameNStop = frameN  # exact frame index
                    win.timeOnFlip(fixation, 'tStopRefresh')  # time at next scr refresh
                    fixation.setAutoDraw(False)
            
            # *letter_0back* updates
            if letter_0back.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                letter_0back.frameNStart = frameN  # exact frame index
                letter_0back.tStart = t  # local t and not account for scr refresh
                letter_0back.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(letter_0back, 'tStartRefresh')  # time at next scr refresh
                letter_0back.setAutoDraw(True)
            if letter_0back.status == STARTED:
                # is it time to stop? (based on global clock, using actual start)
                if tThisFlipGlobal > letter_0back.tStartRefresh + 0.5-frameTolerance:
                    # keep track of stop time/frame for later
                    letter_0back.tStop = t  # not accounting for scr refresh
                    letter_0back.frameNStop = frameN  # exact frame index
                    win.timeOnFlip(letter_0back, 'tStopRefresh')  # time at next scr refresh
                    letter_0back.setAutoDraw(False)
            
            # *key_resp_5* updates
            waitOnFlip = False
            if key_resp_5.status == NOT_STARTED and frameN >= 1:
                # keep track of start time/frame for later
                key_resp_5.frameNStart = frameN  # exact frame index
                key_resp_5.tStart = t  # local t and not account for scr refresh
                key_resp_5.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(key_resp_5, 'tStartRefresh')  # time at next scr refresh
                key_resp_5.status = STARTED
                # keyboard checking is just starting
                waitOnFlip = True
                win.callOnFlip(key_resp_5.clock.reset)  # t=0 on next screen flip
                win.callOnFlip(key_resp_5.clearEvents, eventType='keyboard')  # clear events on next screen flip
            if key_resp_5.status == STARTED:
                # is it time to stop? (based on global clock, using actual start)
                if tThisFlipGlobal > key_resp_5.tStartRefresh + 2.5-frameTolerance:
                    # keep track of stop time/frame for later
                    key_resp_5.tStop = t  # not accounting for scr refresh
                    key_resp_5.frameNStop = frameN  # exact frame index
                    win.timeOnFlip(key_resp_5, 'tStopRefresh')  # time at next scr refresh
                    key_resp_5.status = FINISHED
            if key_resp_5.status == STARTED and not waitOnFlip:
                theseKeys = key_resp_5.getKeys(keyList=['left', 'right'], waitRelease=False)
                _key_resp_5_allKeys.extend(theseKeys)
                if len(_key_resp_5_allKeys):
                    key_resp_5.keys = _key_resp_5_allKeys[0].name  # just the first key pressed
                    key_resp_5.rt = _key_resp_5_allKeys[0].rt
                    # was this correct?
                    if (key_resp_5.keys == str(correct)) or (key_resp_5.keys == correct):
                        key_resp_5.corr = 1
                    else:
                        key_resp_5.corr = 0
            # *stimPort* updates
            if stimPort.status == NOT_STARTED and t >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                stimPort.frameNStart = frameN  # exact frame index
                stimPort.tStart = t  # local t and not account for scr refresh
                stimPort.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(stimPort, 'tStartRefresh')  # time at next scr refresh
                stimPort.status = STARTED
                win.callOnFlip(stimPort.setData, int(255))
            if stimPort.status == STARTED:
                if frameN >= (stimPort.frameNStart + 1):
                    # keep track of stop time/frame for later
                    stimPort.tStop = t  # not accounting for scr refresh
                    stimPort.frameNStop = frameN  # exact frame index
                    win.timeOnFlip(stimPort, 'tStopRefresh')  # time at next scr refresh
                    stimPort.status = FINISHED
                    win.callOnFlip(stimPort.setData, int(0))
            
            # check for quit (typically the Esc key)
            if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
                core.quit()
            
            # check if all components have finished
            if not continueRoutine:  # a component has requested a forced-end of Routine
                break
            continueRoutine = False  # will revert to True if at least one component still running
            for thisComponent in trial_0backComponents:
                if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                    continueRoutine = True
                    break  # at least one component has not yet finished
            
            # refresh the screen
            if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
                win.flip()
        
        # -------Ending Routine "trial_0back"-------
        for thisComponent in trial_0backComponents:
            if hasattr(thisComponent, "setAutoDraw"):
                thisComponent.setAutoDraw(False)
        trialCount +=1
        if trialCount >= len(trialList):
            trialCount = 0
        
        trials.addData('fixation.started', fixation.tStartRefresh)
        trials.addData('fixation.stopped', fixation.tStopRefresh)
        trials.addData('letter_0back.started', letter_0back.tStartRefresh)
        trials.addData('letter_0back.stopped', letter_0back.tStopRefresh)
        # check responses
        if key_resp_5.keys in ['', [], None]:  # No response was made
            key_resp_5.keys = None
            # was no response the correct answer?!
            if str(correct).lower() == 'none':
               key_resp_5.corr = 1;  # correct non-response
            else:
               key_resp_5.corr = 0;  # failed to respond (incorrectly)
        # store data for trials (TrialHandler)
        trials.addData('key_resp_5.keys',key_resp_5.keys)
        trials.addData('key_resp_5.corr', key_resp_5.corr)
        if key_resp_5.keys != None:  # we had a response
            trials.addData('key_resp_5.rt', key_resp_5.rt)
        trials.addData('key_resp_5.started', key_resp_5.tStartRefresh)
        trials.addData('key_resp_5.stopped', key_resp_5.tStopRefresh)
        if stimPort.status == STARTED:
            win.callOnFlip(stimPort.setData, int(0))
        trials.addData('stimPort.started', stimPort.tStart)
        trials.addData('stimPort.stopped', stimPort.tStop)
        thisExp.nextEntry()
        
    # completed totalTrials repeats of 'trials'
    
    thisExp.nextEntry()
    
# completed 1 repeats of 'trials_7'


# set up handler to look after randomisation of conditions etc
trials_4 = data.TrialHandler(nReps=1, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('nBackBlocks.xlsx'),
    seed=None, name='trials_4')
thisExp.addLoop(trials_4)  # add the loop to the experiment
thisTrial_4 = trials_4.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrial_4.rgb)
if thisTrial_4 != None:
    for paramName in thisTrial_4:
        exec('{} = thisTrial_4[paramName]'.format(paramName))

for thisTrial_4 in trials_4:
    currentLoop = trials_4
    # abbreviate parameter names if possible (e.g. rgb = thisTrial_4.rgb)
    if thisTrial_4 != None:
        for paramName in thisTrial_4:
            exec('{} = thisTrial_4[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "transitionSlide"-------
    continueRoutine = True
    # update component parameters for each repeat
    if trials_4.thisN == 0:
        continueRoutine = True
        trialInstruct = 1
        trialInstruct2 = '1 trial ago'
    elif trials_4.thisN == 4:
        continueRoutine = True
        trialInstruct = 2
        trialInstruct2 = '2 trials ago'
    else:
        continueRoutine = False
    text_7.setText(" The next set of blocks are "+ str(trialInstruct) + "-back trials. Remember, this requires you to respond if the current letter is the same as "+ str(trialInstruct2) + ". Press the 'spacebar' to continue.")
    key_resp_11.keys = []
    key_resp_11.rt = []
    _key_resp_11_allKeys = []
    # keep track of which components have finished
    transitionSlideComponents = [text_7, key_resp_11]
    for thisComponent in transitionSlideComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    transitionSlideClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "transitionSlide"-------
    while continueRoutine:
        # get current time
        t = transitionSlideClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=transitionSlideClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *text_7* updates
        if text_7.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            text_7.frameNStart = frameN  # exact frame index
            text_7.tStart = t  # local t and not account for scr refresh
            text_7.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(text_7, 'tStartRefresh')  # time at next scr refresh
            text_7.setAutoDraw(True)
        
        # *key_resp_11* updates
        waitOnFlip = False
        if key_resp_11.status == NOT_STARTED and tThisFlip >= 1.0-frameTolerance:
            # keep track of start time/frame for later
            key_resp_11.frameNStart = frameN  # exact frame index
            key_resp_11.tStart = t  # local t and not account for scr refresh
            key_resp_11.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(key_resp_11, 'tStartRefresh')  # time at next scr refresh
            key_resp_11.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(key_resp_11.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(key_resp_11.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if key_resp_11.status == STARTED and not waitOnFlip:
            theseKeys = key_resp_11.getKeys(keyList=['space'], waitRelease=False)
            _key_resp_11_allKeys.extend(theseKeys)
            if len(_key_resp_11_allKeys):
                key_resp_11.keys = _key_resp_11_allKeys[-1].name  # just the last key pressed
                key_resp_11.rt = _key_resp_11_allKeys[-1].rt
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in transitionSlideComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "transitionSlide"-------
    for thisComponent in transitionSlideComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trialInstruct = 2
    trials_4.addData('text_7.started', text_7.tStartRefresh)
    trials_4.addData('text_7.stopped', text_7.tStopRefresh)
    # check responses
    if key_resp_11.keys in ['', [], None]:  # No response was made
        key_resp_11.keys = None
    trials_4.addData('key_resp_11.keys',key_resp_11.keys)
    if key_resp_11.keys != None:  # we had a response
        trials_4.addData('key_resp_11.rt', key_resp_11.rt)
    trials_4.addData('key_resp_11.started', key_resp_11.tStartRefresh)
    trials_4.addData('key_resp_11.stopped', key_resp_11.tStopRefresh)
    # the Routine "transitionSlide" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "Experimental_Instructions_nback"-------
    continueRoutine = True
    # update component parameters for each repeat
    # usually we would use a conditions file to specify the number of nBack trials
    # but we want to ensure the position of the first n-Back trial
    # adapts to the requested n. i.e. if this is a 4-back trial
    # we cannot present an n-Back trial in the first 3 trials
    
    # what is the n (e.g. n = 2 "remember if this item is the same as 2 back")
    n = N_trial
    # how many trials in total?
    totalTrials = 1
    # how many n-Back trials?
    nBackTrials = 6
    #how many blocks?
    blocks = 8
    
    # make a list of trials; 0 = not nBack; 1 = nBack trial
    #trialList = [0]*(totalTrials-nBackTrials)+[1]*nBackTrials
    
    # buffer trials = first set of trials where an n-back trial cannot be presented
    #bufferTrials = trialList[:n]
    
    # experimental trials - include nBack trials
    #experimentalTrials = trialList[n:]
    
    # randomise the experimental trials
    #shuffle(experimentalTrials)
    
    # combine the buffer trials and experimental trials to make the final trialList
    #trialList = bufferTrials+experimentalTrials
    
    list1 = [0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1]
    list2 = [0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1]
    list3 = [0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1]
    list4 = [0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0]
    list5 = [0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1]
    list6 = [0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1]
    list7 = [0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1]
    list8 = [0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1]
    
    
    trialOrder1 = [list1, list2, list3, list4, list5, list6, list7, list8]
    trialOrder2 = [list2, list3, list4, list1, list6, list7, list8, list5]
    trialOrder3 = [list3, list4, list1, list2, list7, list8, list5, list6]
    trialOrder4 = [list4, list1, list2, list3, list8, list5, list6, list7]
    
    if expInfo['session'] == '1':
        sessOrder = trialOrder1
    elif expInfo['session'] == '2':
        sessOrder = trialOrder2
    elif expInfo['session'] == '3':
        sessOrder = trialOrder3
    elif expInfo['session'] == '4':
        sessOrder = trialOrder4
    
    ele = trials_4.thisTrialN
    if ele < blocks:
        trialList = sessOrder[ele]
    
    expInstructions.setText("This is an experimental block of the  "  + str(n) + "-back task. Press the " + str(key1) + " key if the current letter is the same as " + str(n) + " prior to it (upper or lower case). If it is not, press the " + str(key2) + " key. The letters will flash briefly on screen and you may respond even after the letter disappears during the '+'. Press the 'spacebar' to begin the task.")
    key_resp_3.keys = []
    key_resp_3.rt = []
    _key_resp_3_allKeys = []
    # keep track of which components have finished
    Experimental_Instructions_nbackComponents = [expInstructions, key_resp_3]
    for thisComponent in Experimental_Instructions_nbackComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    Experimental_Instructions_nbackClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "Experimental_Instructions_nback"-------
    while continueRoutine:
        # get current time
        t = Experimental_Instructions_nbackClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=Experimental_Instructions_nbackClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *expInstructions* updates
        if expInstructions.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            expInstructions.frameNStart = frameN  # exact frame index
            expInstructions.tStart = t  # local t and not account for scr refresh
            expInstructions.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(expInstructions, 'tStartRefresh')  # time at next scr refresh
            expInstructions.setAutoDraw(True)
        
        # *key_resp_3* updates
        waitOnFlip = False
        if key_resp_3.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            key_resp_3.frameNStart = frameN  # exact frame index
            key_resp_3.tStart = t  # local t and not account for scr refresh
            key_resp_3.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(key_resp_3, 'tStartRefresh')  # time at next scr refresh
            key_resp_3.status = STARTED
            # keyboard checking is just starting
            waitOnFlip = True
            win.callOnFlip(key_resp_3.clock.reset)  # t=0 on next screen flip
            win.callOnFlip(key_resp_3.clearEvents, eventType='keyboard')  # clear events on next screen flip
        if key_resp_3.status == STARTED and not waitOnFlip:
            theseKeys = key_resp_3.getKeys(keyList=['space'], waitRelease=False)
            _key_resp_3_allKeys.extend(theseKeys)
            if len(_key_resp_3_allKeys):
                key_resp_3.keys = _key_resp_3_allKeys[-1].name  # just the last key pressed
                key_resp_3.rt = _key_resp_3_allKeys[-1].rt
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in Experimental_Instructions_nbackComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "Experimental_Instructions_nback"-------
    for thisComponent in Experimental_Instructions_nbackComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trials_4.addData('expInstructions.started', expInstructions.tStartRefresh)
    trials_4.addData('expInstructions.stopped', expInstructions.tStopRefresh)
    # the Routine "Experimental_Instructions_nback" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "fixation_2"-------
    continueRoutine = True
    routineTimer.add(2.000000)
    # update component parameters for each repeat
    # keep track of which components have finished
    fixation_2Components = [fixation_start]
    for thisComponent in fixation_2Components:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    fixation_2Clock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "fixation_2"-------
    while continueRoutine and routineTimer.getTime() > 0:
        # get current time
        t = fixation_2Clock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=fixation_2Clock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *fixation_start* updates
        if fixation_start.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            fixation_start.frameNStart = frameN  # exact frame index
            fixation_start.tStart = t  # local t and not account for scr refresh
            fixation_start.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(fixation_start, 'tStartRefresh')  # time at next scr refresh
            fixation_start.setAutoDraw(True)
        if fixation_start.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > fixation_start.tStartRefresh + 2-frameTolerance:
                # keep track of stop time/frame for later
                fixation_start.tStop = t  # not accounting for scr refresh
                fixation_start.frameNStop = frameN  # exact frame index
                win.timeOnFlip(fixation_start, 'tStopRefresh')  # time at next scr refresh
                fixation_start.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in fixation_2Components:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "fixation_2"-------
    for thisComponent in fixation_2Components:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    trials_4.addData('fixation_start.started', fixation_start.tStartRefresh)
    trials_4.addData('fixation_start.stopped', fixation_start.tStopRefresh)
    
    # set up handler to look after randomisation of conditions etc
    trials_3 = data.TrialHandler(nReps=totalTrials, method='random', 
        extraInfo=expInfo, originPath=-1,
        trialList=[None],
        seed=None, name='trials_3')
    thisExp.addLoop(trials_3)  # add the loop to the experiment
    thisTrial_3 = trials_3.trialList[0]  # so we can initialise stimuli with some values
    # abbreviate parameter names if possible (e.g. rgb = thisTrial_3.rgb)
    if thisTrial_3 != None:
        for paramName in thisTrial_3:
            exec('{} = thisTrial_3[paramName]'.format(paramName))
    
    for thisTrial_3 in trials_3:
        currentLoop = trials_3
        # abbreviate parameter names if possible (e.g. rgb = thisTrial_3.rgb)
        if thisTrial_3 != None:
            for paramName in thisTrial_3:
                exec('{} = thisTrial_3[paramName]'.format(paramName))
        
        # ------Prepare to start Routine "trial_nback_2"-------
        continueRoutine = True
        routineTimer.add(2.500000)
        # update component parameters for each repeat
        thisTrialType = trialList[trialCount]
        thisLetter = "0"
        letterSet = allLetters
        
        flag = 0
        pulse_sent = False
        respPortn.setData(0)
        pulse_terminated = True
        
        if thisTrialType == 0 :# not an n-back trial
            if trialCount > 1:
                availLetters = np.setdiff1d(letterSet,lettersShown[-n::])
                shuffle(availLetters)
                thisLetter = availLetters[-1]
            else:
                availLetters = letterSet
                shuffle(availLetters)
                thisLetter = availLetters[-1]
        elif thisTrialType ==1: # an n-back trial
            thisLetter = lettersShown[-n]
        
        lettersShown.append(thisLetter)
        trials.addData('trialCount', trialCount)
        trials.addData('itemPresented', thisLetter)
        trials.addData('trialType', thisTrialType)
        
        
        #correct trials
        if thisTrialType == 1:
            correct = 'right'
        else:
            correct = 'left'
        
        letter.setText(thisLetter.join(choice((str.upper, str.lower))(c) for c in thisLetter)
)
        key_resp_2.keys = []
        key_resp_2.rt = []
        _key_resp_2_allKeys = []
        # keep track of which components have finished
        trial_nback_2Components = [letter, key_resp_2, stimPortn, text_6]
        for thisComponent in trial_nback_2Components:
            thisComponent.tStart = None
            thisComponent.tStop = None
            thisComponent.tStartRefresh = None
            thisComponent.tStopRefresh = None
            if hasattr(thisComponent, 'status'):
                thisComponent.status = NOT_STARTED
        # reset timers
        t = 0
        _timeToFirstFrame = win.getFutureFlipTime(clock="now")
        trial_nback_2Clock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
        frameN = -1
        
        # -------Run Routine "trial_nback_2"-------
        while continueRoutine and routineTimer.getTime() > 0:
            # get current time
            t = trial_nback_2Clock.getTime()
            tThisFlip = win.getFutureFlipTime(clock=trial_nback_2Clock)
            tThisFlipGlobal = win.getFutureFlipTime(clock=None)
            frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
            # update/draw components on each frame
            if key_resp_2.status == STARTED and flag == 0:
                if key_resp_2.keys == 'right' or key_resp_2.keys == 'left':
                    pulse_start_time = t
                    pulse_sent = True
                    pulse_terminate = False
                    respPortn.setData(255)
                    time.sleep(.05)
                    respPortn.setData(0)
                    flag = 1
            
            #if pulse_sent and not pulse_terminate:
            #    if t - pulse_start_time >= .04:
            #        p_port_8.setData(0)
            #        pulse_terminate = TRUE
            
            # *letter* updates
            if letter.status == NOT_STARTED and tThisFlip >= 0-frameTolerance:
                # keep track of start time/frame for later
                letter.frameNStart = frameN  # exact frame index
                letter.tStart = t  # local t and not account for scr refresh
                letter.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(letter, 'tStartRefresh')  # time at next scr refresh
                letter.setAutoDraw(True)
            if letter.status == STARTED:
                # is it time to stop? (based on global clock, using actual start)
                if tThisFlipGlobal > letter.tStartRefresh + 0.5-frameTolerance:
                    # keep track of stop time/frame for later
                    letter.tStop = t  # not accounting for scr refresh
                    letter.frameNStop = frameN  # exact frame index
                    win.timeOnFlip(letter, 'tStopRefresh')  # time at next scr refresh
                    letter.setAutoDraw(False)
            
            # *key_resp_2* updates
            waitOnFlip = False
            if key_resp_2.status == NOT_STARTED and frameN >= 1:
                # keep track of start time/frame for later
                key_resp_2.frameNStart = frameN  # exact frame index
                key_resp_2.tStart = t  # local t and not account for scr refresh
                key_resp_2.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(key_resp_2, 'tStartRefresh')  # time at next scr refresh
                key_resp_2.status = STARTED
                # keyboard checking is just starting
                waitOnFlip = True
                win.callOnFlip(key_resp_2.clock.reset)  # t=0 on next screen flip
                win.callOnFlip(key_resp_2.clearEvents, eventType='keyboard')  # clear events on next screen flip
            if key_resp_2.status == STARTED:
                # is it time to stop? (based on global clock, using actual start)
                if tThisFlipGlobal > key_resp_2.tStartRefresh + 2.5-frameTolerance:
                    # keep track of stop time/frame for later
                    key_resp_2.tStop = t  # not accounting for scr refresh
                    key_resp_2.frameNStop = frameN  # exact frame index
                    win.timeOnFlip(key_resp_2, 'tStopRefresh')  # time at next scr refresh
                    key_resp_2.status = FINISHED
            if key_resp_2.status == STARTED and not waitOnFlip:
                theseKeys = key_resp_2.getKeys(keyList=['left', 'right'], waitRelease=False)
                _key_resp_2_allKeys.extend(theseKeys)
                if len(_key_resp_2_allKeys):
                    key_resp_2.keys = _key_resp_2_allKeys[0].name  # just the first key pressed
                    key_resp_2.rt = _key_resp_2_allKeys[0].rt
                    # was this correct?
                    if (key_resp_2.keys == str(correct)) or (key_resp_2.keys == correct):
                        key_resp_2.corr = 1
                    else:
                        key_resp_2.corr = 0
            # *stimPortn* updates
            if stimPortn.status == NOT_STARTED and t >= 0.0-frameTolerance:
                # keep track of start time/frame for later
                stimPortn.frameNStart = frameN  # exact frame index
                stimPortn.tStart = t  # local t and not account for scr refresh
                stimPortn.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(stimPortn, 'tStartRefresh')  # time at next scr refresh
                stimPortn.status = STARTED
                win.callOnFlip(stimPortn.setData, int(255))
            if stimPortn.status == STARTED:
                if frameN >= (stimPortn.frameNStart + 1):
                    # keep track of stop time/frame for later
                    stimPortn.tStop = t  # not accounting for scr refresh
                    stimPortn.frameNStop = frameN  # exact frame index
                    win.timeOnFlip(stimPortn, 'tStopRefresh')  # time at next scr refresh
                    stimPortn.status = FINISHED
                    win.callOnFlip(stimPortn.setData, int(0))
            
            # *text_6* updates
            if text_6.status == NOT_STARTED and tThisFlip >= 0.5-frameTolerance:
                # keep track of start time/frame for later
                text_6.frameNStart = frameN  # exact frame index
                text_6.tStart = t  # local t and not account for scr refresh
                text_6.tStartRefresh = tThisFlipGlobal  # on global time
                win.timeOnFlip(text_6, 'tStartRefresh')  # time at next scr refresh
                text_6.setAutoDraw(True)
            if text_6.status == STARTED:
                # is it time to stop? (based on global clock, using actual start)
                if tThisFlipGlobal > text_6.tStartRefresh + 2-frameTolerance:
                    # keep track of stop time/frame for later
                    text_6.tStop = t  # not accounting for scr refresh
                    text_6.frameNStop = frameN  # exact frame index
                    win.timeOnFlip(text_6, 'tStopRefresh')  # time at next scr refresh
                    text_6.setAutoDraw(False)
            
            # check for quit (typically the Esc key)
            if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
                core.quit()
            
            # check if all components have finished
            if not continueRoutine:  # a component has requested a forced-end of Routine
                break
            continueRoutine = False  # will revert to True if at least one component still running
            for thisComponent in trial_nback_2Components:
                if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                    continueRoutine = True
                    break  # at least one component has not yet finished
            
            # refresh the screen
            if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
                win.flip()
        
        # -------Ending Routine "trial_nback_2"-------
        for thisComponent in trial_nback_2Components:
            if hasattr(thisComponent, "setAutoDraw"):
                thisComponent.setAutoDraw(False)
        trialCount +=1
        if trialCount >= len(trialList):
            trialCount = 0
        
        trials_3.addData('letter.started', letter.tStartRefresh)
        trials_3.addData('letter.stopped', letter.tStopRefresh)
        # check responses
        if key_resp_2.keys in ['', [], None]:  # No response was made
            key_resp_2.keys = None
            # was no response the correct answer?!
            if str(correct).lower() == 'none':
               key_resp_2.corr = 1;  # correct non-response
            else:
               key_resp_2.corr = 0;  # failed to respond (incorrectly)
        # store data for trials_3 (TrialHandler)
        trials_3.addData('key_resp_2.keys',key_resp_2.keys)
        trials_3.addData('key_resp_2.corr', key_resp_2.corr)
        if key_resp_2.keys != None:  # we had a response
            trials_3.addData('key_resp_2.rt', key_resp_2.rt)
        trials_3.addData('key_resp_2.started', key_resp_2.tStartRefresh)
        trials_3.addData('key_resp_2.stopped', key_resp_2.tStopRefresh)
        if stimPortn.status == STARTED:
            win.callOnFlip(stimPortn.setData, int(0))
        trials_3.addData('stimPortn.started', stimPortn.tStart)
        trials_3.addData('stimPortn.stopped', stimPortn.tStop)
        trials_3.addData('text_6.started', text_6.tStartRefresh)
        trials_3.addData('text_6.stopped', text_6.tStopRefresh)
        thisExp.nextEntry()
        
    # completed totalTrials repeats of 'trials_3'
    
    thisExp.nextEntry()
    
# completed 1 repeats of 'trials_4'


# ------Prepare to start Routine "endStudy"-------
continueRoutine = True
routineTimer.add(3.000000)
# update component parameters for each repeat
# keep track of which components have finished
endStudyComponents = [text]
for thisComponent in endStudyComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
endStudyClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "endStudy"-------
while continueRoutine and routineTimer.getTime() > 0:
    # get current time
    t = endStudyClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=endStudyClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text* updates
    if text.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        text.frameNStart = frameN  # exact frame index
        text.tStart = t  # local t and not account for scr refresh
        text.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(text, 'tStartRefresh')  # time at next scr refresh
        text.setAutoDraw(True)
    if text.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > text.tStartRefresh + 3-frameTolerance:
            # keep track of stop time/frame for later
            text.tStop = t  # not accounting for scr refresh
            text.frameNStop = frameN  # exact frame index
            win.timeOnFlip(text, 'tStopRefresh')  # time at next scr refresh
            text.setAutoDraw(False)
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in endStudyComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "endStudy"-------
for thisComponent in endStudyComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('text.started', text.tStartRefresh)
thisExp.addData('text.stopped', text.tStopRefresh)

# Flip one final time so any remaining win.callOnFlip() 
# and win.timeOnFlip() tasks get executed before quitting
win.flip()

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv', delim='auto')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()
