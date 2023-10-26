# -*- coding: utf-8 -*-
"""
Created on Wed Oct  4 17:37:28 2023

@author: julia
"""

# Import needed packages
import pandas as pd


# Load in output excel sheet
df = pd.read_excel('Navon_Behavioral_LongFormat_PRISM_final_x4_z_day_thres.xlsx')
ref = pd.read_excel('efield_ed_data.xlsx')

# Find values to write to 
for index, row in ref.iterrows():
    subj = row['Subject']
    site = row['Site']
    efield_value = row['efield']
    ed_value = row['ed']
    edt_value = row['edt']
    
    matching_rows = df[(df['Subj'] == subj) & (df['Stimulation_Site'] == site)]
    
    df.loc[matching_rows.index, 'efield'] = efield_value
    
    df.loc[matching_rows.index, 'ed'] = ed_value
    
    df.loc[matching_rows.index, 'edt'] = edt_value

# Save dataframe as excel 
df.to_excel("Navon_Behavioral_LongFormat_PRISM_final_x4_z_day_efield.xlsx", index=False)