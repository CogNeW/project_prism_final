# -*- coding: utf-8 -*-
"""
Created on Wed Oct  4 16:56:29 2023

@author: julia
"""

# Import needed packages
import pandas as pd


# Load in output excel sheet
df = pd.read_excel('Navon_Behavioral_LongFormat_PRISM_final_x4_z_day_r.xlsx')


#Stimulated Correctly == 1
correctstim = ['P_HGO','P_LFJ', 'P_DQF', 'P_GLA', 'D_PYL', 'D_RTA', 'D_HTY', 'D_BWR', 'P_DFC']
df.loc[df['Subj'].isin(correctstim), 'Threshold'] = 1
df.loc[(df['Subj'] == 'D_KIF') & (df['Stimulation_Site'] == 'DAN'), 'Threshold'] = 1

# Stimulated Below Threshold == 0
belowstim = ['P_VTE','P_WSB', 'P_ZHD', 'P_XZO', 'D_EMO', 'D_TPE', 'D_PEU', 'D_VAZ', 'D_OAC', 'D_KUR', 'D_TSU']
# Also need 'D_KIF' for Vertex and FPCN-B
df.loc[df['Subj'].isin(belowstim), 'Threshold'] = 0
df.loc[(df['Subj'] == 'D_KIF') & (df['Stimulation_Site'] == 'Vertex'), 'Threshold'] = 0
df.loc[(df['Subj'] == 'D_KIF') & (df['Stimulation_Site'] == 'FPCN-B'), 'Threshold'] = 0

# Save dataframe 2 as excel 
df.to_excel("Navon_Behavioral_LongFormat_PRISM_final_x4_z_day_thres.xlsx", index=False)