"""N-back Task Reader

This script reads in the behavioral data output from Psychopy after running the n-back task and creates
a more reader-friendly csv output for visual inspection/analyses. 

It prompts the user for two inputs: the file path to the n-back folder and the name of the subject file to be analyzed.

NOTE: A results_output/ folder must exist within the same directory as this script, as this is where the output of the script is saved.
This is done to avoid the csv files created from being mixed up with any other files.

This file can also be imported as a module and contains the following functions:

	* are_within_exp_ranges - takes a value along with several other parameters to determine if the value falls between these other ranges passed into it
	* struct_new_str_for_csv_file - takes in the original csv line along with the positions of the relevant info wanted and creates a newly formatted string
		that will be written out into the new csv output file
	* write_initial_header - writes a specific header to the output csv files, given the filename to write out to
	* find_start_of_trial_types - takes in data to iterate through and determines where each n-back trial starts based on the index to begin iterating through, as well as what trial type is 		being searched for
	* main - the main function of the script

"""

import csv, io, os, sys, pandas, numpy, re
def are_within_exp_ranges(count, low_range_1, high_range_1, low_range_2, high_range_2, low_range_3, high_range_3, low_range_4, high_range_4):
	'''Returns a Boolean that denotes whether an index given is within the specified ranges given, specifically when checking the experimental data'''
	return (low_range_1 <= count <= high_range_1) or (low_range_2 <= count <= high_range_2) or (low_range_3 <= count <= high_range_3) or (low_range_4 <= count <= high_range_4)
def struct_new_str_for_csv_file(csv_line, nBack_type, rt_index, correct_index, info_list_to_append, sub_name, stim, ses, trialN, trialType, block, counter, sessNum, days):
	'''Takes in indices for respective columns of interest, creates the appropriate comma-separated string, and appends it to its corresponding info list to be written into a csv later.'''
	react_time = csv_line[rt_index]
	correct = csv_line[correct_index]
	# adds 1 to avoid 0 indexing by Python		
	formattedTrialN = int(trialN) + 1
	formattedBlock = int(block) + 1
	# create string that will be stored in a list that will become a csv row in the output
	new_str = sub_name + ',' + str(nBack_type) + ',' + str(formattedTrialN) + ',' + str(formattedBlock) + ',' + react_time + ',' + correct + ',' + trialType + ',' + stim + ',' + ses.lower() + "," + counter + "," + sessNum + "," + days
	info_list_to_append.append(new_str)
def write_initial_header(file_to_write):
	'''Writes the initial header for a passed in file'''
	file_to_write.write('subject,n_back,trialN,blockN,rt,correct,trialType,stim_site,timepoint,counterbalance,sessionNum,days\n')
def find_start_of_trial_types(lines, nBackType, startIndex, typeIndex):
	'''Locate the first index in which a certain n-back type occurs in a column'''
	for i in range(startIndex, len(lines)):
		curr_line = lines[i].split(',')
		if curr_line[typeIndex] == nBackType:
			return i
def find_last_trial(lines, start_index, trial_index):
	'''Iterate through a list and find the number of the last trial that occurs'''
	# iterate through rows backwards to look for the last trial
	for i in range((len(lines) - 1), start_index, -1):
		curr_line = lines[i].split(',')
		if curr_line[trial_index] == '17':
			return i
def find_session_num(sheet, targetName, targetSite):
	'''Find a subject's session number once being passed in their name and stim site'''
	# https://stackoverflow.com/questions/16476924/how-to-iterate-over-rows-in-a-dataframe-in-pandas
	regex = re.compile('[^a-z]')
	for row in sheet.itertuples():
		if not(numpy.isnan(row[2])):
			currName = regex.sub('', row[1].lower())
			currSite = regex.sub('', row[3].lower())
			targetName = regex.sub('', targetName.lower())
			targetSite = regex.sub('', targetSite.lower())
			if (currName == targetName) and (currSite == targetSite):
				return str(int(row[2]))
def normalize_stim_site(origSite):
	'''Takes in string of stimulation site to make it consistent in how its written'''
	regex = re.compile('[^A-Z]')
	if origSite.lower() == "vertex":
		newName = origSite.lower()
		return newName
	elif origSite.lower() == "dan":
		newName = origSite.upper()
		return newName
	# if its anything else, it has to be the FPCN-B target
	else:
		origSite = regex.sub('', origSite.upper())
		return origSite
def find_session_days(lines, targetName, targetSesNum):
	'''Find a subject's number of days in between sessions with respect to their session number and subject name'''
	for i in range(0, len(lines)):
		curr_line = lines[i].split(',')
		session = curr_line[2].strip()
		if (curr_line[0] == targetName) and (session == targetSesNum):
			return curr_line[1]
def main():
	'''Main script for the n-back task reader'''
	# have checks in place to make sure a directory is read in and all required directories/files are created
	if len(sys.argv) != 2:
		print('USAGE: N_BACK_DIR')
		sys.exit()
	if not(os.path.isdir('./results_output/')):
		print('ERROR: Must create a results_output/ directory at the same level of the script to run it.')
		sys.exit()
	if not(os.path.isfile('./pilot_study_rand_subject_v3.xlsx')):
		print('ERROR: Must have randomization sheet at the same level of the script to run it.')
		sys.exit()
	if not(os.path.isfile('./prism_days.csv')):
		print('ERROR: Must have number of days sheet at same level of the script to run it')
		sys.exit()

	# grab the lists of all subjects		
	nBack_path = sys.argv[1]
	list_of_subj = os.listdir(nBack_path)
	# sort the subject names so subjects are grouped by ID
	list_of_subj.sort()

	# create initial csv files to be written into
	new_prac_name = './results_output/n-back_prac_results.csv'
	prac_file = open(new_prac_name, 'w', newline='')
	write_initial_header(prac_file)

	new_exp_name = './results_output/n-back_exp_results.csv'
	exp_file = open(new_exp_name, 'w', newline='')
	write_initial_header(exp_file)

	# grab initial excel sheet to grab session nums
	randSheet = pandas.read_excel('./pilot_study_rand_subject_v3.xlsx')

	# open csv to help grab days between sessions
	daysSheet = open('./prism_days.csv', mode='r')
	daysData = daysSheet.readlines()

	# loop through each subject folder, one at a time, to get the proper info for parsing
	for subject in list_of_subj:
		# check if directory is valid or a regular file, if so, skip over it
		entire_path = nBack_path + subject
		if not(os.path.isdir(entire_path)):
			continue
		files = os.listdir(entire_path)

		# grab all csvs from the directory and sort them (which will sort them by time since the filenames have time stamps)
		interest_csvs = list(filter(lambda x: x.endswith('.csv'), files))
		interest_csvs.sort()

		# iterate through CSVs of interest, reading their associated info and putting them into lists to be written out
		prac_info = []
		exp_info = []
		for filename in interest_csvs:
			path_to_csv = entire_path + '/' + filename
			f = open(path_to_csv, mode='r', encoding='utf-8-sig')
			raw_data = f.readlines()
			numOfLines = len(raw_data)
			
			# checks if the csv is the practice one, as it has different indices to check for
			if 'prac' in filename:
				header_list = raw_data[0].split(',')

				# look for first csv line that has a 1 since num of 0- and 1-back trials can vary
				start_of_1Back_index = find_start_of_trial_types(raw_data, '1', 6, 0)
				start_of_2Back_index = find_start_of_trial_types(raw_data, '2', start_of_1Back_index, 0)
				last_trial_index = find_last_trial(raw_data, 6, 17)

				# create a flag to denote whether they even have the start of the 2-back trials
				if start_of_2Back_index == None:
					has2BackTrials = 0
				else:
					has2BackTrials = 1

				# get the column indices of these headers to avoid relying on hardcoded indices
				rt_0back_index = header_list.index('key_resp_5.rt')
				rt_1_and_2back_index = header_list.index('key_resp_2.rt')
				block_0back_index = header_list.index('trials_3.thisN')
				block_1_and_2back_index = header_list.index('trials_4.thisN')
				subj_index = header_list.index('participant')
				counter_index = header_list.index('counterbalance')

				# since the header for 'stim site' can be messed up sometimes, we can only rely on it always being next to the session info
				ses_index = [idx for idx, head in enumerate(header_list) if 'session' in head][0]
				stim_index = ses_index + 1

				# since these values are constant, grab them from first row to have it
				first_row = raw_data[1].split(',')
				subj_name = first_row[subj_index]
				session = first_row[ses_index]
				stim_site = normalize_stim_site(first_row[stim_index])
				counterbalance = first_row[counter_index]

				# find session number from randomization sheet
				ses_num = find_session_num(randSheet, subj_name, stim_site)

				# find days in between session from prism_days csv
				days = find_session_days(daysData, subj_name, ses_num)

				# iterate through all lines of csv and get necessary info for appending to final csv
				trialCounter = 0
				for line_num in range(6, (last_trial_index + 1)):
					if trialCounter <= 17:
						# if statement to skip over that extra blank line that separates the 1- and 2-back trials
						if has2BackTrials and line_num == (start_of_2Back_index - 1):
							continue
						currentLine = raw_data[line_num].split(',')
						trial_type = currentLine[57]
						# iterates only over the lines that have data that we want to parse through
						if (6 <= line_num <= (start_of_1Back_index - 2)):
							trial_num = currentLine[5]
							blockNum = currentLine[block_0back_index]
							struct_new_str_for_csv_file(currentLine, 0, rt_0back_index, 63, prac_info, subj_name, stim_site, session, trial_num, trial_type, blockNum, counterbalance, ses_num, days)
						# iterate over 1- and 2-back trials based on indices that we retrieved
						elif (has2BackTrials and ((start_of_1Back_index <= line_num <= (start_of_2Back_index - 2)) or (start_of_2Back_index <= line_num <= (numOfLines - 2)))) or (start_of_1Back_index <= line_num <= last_trial_index):
							nBackType = currentLine[0]
							trial_num = currentLine[17]
							blockNum = currentLine[block_1_and_2back_index]
							struct_new_str_for_csv_file(currentLine, nBackType, rt_1_and_2back_index, 81, prac_info, subj_name, stim_site, session, trial_num, trial_type, blockNum, counterbalance, ses_num, days)
						trialCounter += 1
					else:
						# reset trial counter once it is greater than 17
						trialCounter = 0

				# write strings into practice csv file
				csv_write = csv.writer(prac_file, delimiter = ',')
				csv_write.writerows([row.split(',') for row in prac_info])

			else:
				header_list = raw_data[0].split(',')

				# get 1- and 2-back start indices
				start_of_1Back_index = find_start_of_trial_types(raw_data, '1', 2, 1)
				start_of_2Back_index = find_start_of_trial_types(raw_data, '2', start_of_1Back_index, 1)

				# grab row indices based on their column name or relative positioning to another column
				rt_0_back_index = header_list.index('key_resp_5.rt')
				rt_1_and_2back_index = header_list.index('key_resp_2.rt')
				block_0back_index = header_list.index('trials_7.thisN')
				block_1_and_2back_index = header_list.index('trials_4.thisN')
				subj_index = header_list.index('participant')
				counter_index = header_list.index('counterbalance')

				ses_index = [idx for idx, head in enumerate(header_list) if 'session' in head][0]
				stim_index = ses_index + 1

				# since these values are constant, grab them from first row to have it
				first_row = raw_data[1].split(',')
				subj_name = first_row[subj_index]
				session = first_row[ses_index]
				stim_site = normalize_stim_site(first_row[stim_index])
				counterbalance = first_row[counter_index]

				# find session number from randomization sheets
				ses_num = find_session_num(randSheet, subj_name, stim_site)

				# find days in between session from prism_days csv
				days = find_session_days(daysData, subj_name, ses_num)

				# set a trial counter to loop over only every 18 blocks of lines
				trial_counter = 0
				for line_num in range(2, numOfLines - 1):
					if trial_counter <= 17:
						currentLine = raw_data[line_num].split(',')
						trial_num = currentLine[28]
						trial_type = currentLine[30]
						if (2 <= line_num <= (start_of_1Back_index - 2)):
							nBackType = currentLine[0]
							blockNum = currentLine[block_0back_index]
							struct_new_str_for_csv_file(currentLine, nBackType, rt_0_back_index, 36, exp_info, subj_name, stim_site, session, trial_num, trial_type, blockNum, counterbalance, ses_num, days)
						elif (start_of_1Back_index <= line_num <= (start_of_2Back_index - 2)) or (start_of_2Back_index <= line_num <= (numOfLines - 1)):
							nBackType = currentLine[1]
							blockNum = int(currentLine[block_1_and_2back_index])
							# decrement by 4 if the block numis greater than 3, since it's counting the 1- and 2-back blocks together
							if blockNum > 3:
								blockNum -= 4
							struct_new_str_for_csv_file(currentLine, nBackType, rt_1_and_2back_index, 51, exp_info, subj_name, stim_site, session, trial_num, trial_type, blockNum, counterbalance, ses_num, days)
						trial_counter += 1
					else:
						trial_counter = 0

				# write strings into experiment csv file
				csv_write = csv.writer(exp_file, delimiter = ',')
				csv_write.writerows([row.split(',') for row in exp_info])

				# clear lists to allow new data to be calculated for other conditions
				exp_info = []

			# ensure to close the file that was opened that we were reading info from
			f.close()
			
	# ensure to close the files that were being created and written into
	prac_file.close()
	exp_file.close()


if __name__ == '__main__':
	main()