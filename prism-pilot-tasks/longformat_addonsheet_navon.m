%% Instructions for writing to longformat
%  by Julia Dengler
% 1) Use existing excel file, make sure updated version is saved and in the
%   same folder as this script
% 2) Input which subjects you want to write into excel, by adding subject
%   ID to answer variable (please wait until all sessions are done to
%   upload data)
% 3) Make sure all .mat files for the actual experiment are in the same
%   folder as this script
% 4) Make sure excel is not open on computer
%
%% This script takes each subject's Navon outputs and inputs them into the
% long format spreadsheet

% Read in partially completed Behavioral sheet
[num,txt,output]=xlsread('Navon_Behavioral_LongFormat_PRISM.xlsx');
[num,txt,sublist]=xlsread('sublist.xlsx');
[num,txt,randomizer]=xlsread('pilot_study_rand_subject_v3.xlsx');

%% Ask user what subjects they want to enter
answer={'P_HGO'
'P_VTE'
'P_WSB'
'P_FDC'
'P_LFJ'
'P_ZHD'
'P_DQF'
'P_XZO'
'P_GLA'
'D_KIF'
'D_EMO'
'D_TPE'
'D_PYL'
'D_OAC'
};
%{'P_XXX','P_XXX'};

%% Finds index for subjects entered and adds them to the 
sublist=cellstr(sublist);

for i=1:length(answer)
    subject_entered(i)=find(strcmp(sublist,answer(i)));
end

% Each subject has 144 trials for high and low conditions and then 3
% sessions for a total of 1728 rows needed for each subject

for i=1:length(answer)
    k=subject_entered(1,i);
    columnid1=find(strcmp(output(1,:),"Subj"));
    output((((k-1)*1728)+2):(((k-1)*1728)+1729),columnid1)=repmat(sublist(k,1),1728,1);
end

%% Add Patterned Data for each subject
ntrials=144;
nsessions=3;
for i=1:length(answer)
    index=find(strcmp(answer(i),output));
    % Adds Stimulation Sites in pattern
    stim_sites={'Vertex','FPCN-B','DAN'};
    stimpattern = repelem(stim_sites,ntrials*4)';
    columnid13=find(strcmp(output(1,:),"Stimulation_Site"));
    output(index,columnid13)=stimpattern;
    % Adds Conditions in pattern
    lowhigh={'low','high'};
    condpattern = repelem(lowhigh,ntrials)';
    columnid11=find(strcmp(output(1,:),"Task_Low_High"));
    output(index,columnid11)=repmat(condpattern,nsessions*2,1);
    % Adds Timepoints in pattern
    timepoints={'pre','post'};
    timepattern=repelem(timepoints,ntrials*2)';
    columnid14=find(strcmp(output(1,:),"Timepoint"));
    output(index,columnid14)=repmat(timepattern,nsessions,1);
    % Add Session number pulling from Randomizer Sheet
    subjectrandindx=find(strcmp(answer(i), randomizer(:,1)));
    columnidrandtar=find(strcmp(randomizer(1,:),'Target'));
    columnidrandses=find(strcmp(randomizer(1,:),'Session'));
    dansession=find(strcmp(randomizer(subjectrandindx,columnidrandtar),'DAN'));
    fpcnbsession=find(strcmp(randomizer(subjectrandindx,columnidrandtar),'FPCN-B'));
    vertexsession=find(strcmp(randomizer(subjectrandindx,columnidrandtar),'Vertex'));
    danrowsout=find(strcmp(output(index,columnid13),'DAN'));
    fpcnbrowsout=find(strcmp(output(index,columnid13),'FPCN-B'));
    vertexrowsout=find(strcmp(output(index,columnid13),'Vertex'));
    columnid2=find(strcmp(output(1,:),'Session_Number'));
    output(danrowsout,columnid2)=repmat(randomizer(dansession,columnidrandses),length(danrowsout));
    output(fpcnbrowsout,columnid2)=repmat(randomizer(fpcnbsession,columnidrandses),length(fpcnbrowsout));
    output(vertexrowsout,columnid2)=repmat(randomizer(vertexsession,columnidrandses),length(vertexrowsout));
end

%% Pulls data for each trial from .mat files
files=dir('*navon*.mat');
for i=1:length(answer)
    for f =1:length(files)
        [filepath, file, ~] = fileparts(files(f).name);
        fileinfo = strsplit(file,'_');
        fileinfochar=char(fileinfo);
        fileinfochar(8,:)=lower(fileinfochar(8,:));
        fileinfo=cellstr(fileinfochar)';
        %if strcmp(fileinfo{3},'navon')
        if strcmp(fileinfo{6},'expA')|| strcmp(fileinfo{6},'expB')|| strcmp(fileinfo{6},'expC')|| strcmp(fileinfo{6},'expD')|| strcmp(fileinfo{6},'expE')|| strcmp(fileinfo{6},'expF')
            %Find Rows that meet all the criteria within the file title
            subjectrows=find((strcmp(answer{i},output(:,1))) & (strcmp(fileinfo{9},output(:,12))) & (strcmp(fileinfo{8},output(:,13))) & (strcmp(fileinfo{5},output(:,10))));
            % Add column of first color
            columnid4=find(strcmp(output(1,:),"Initial_color"));
            output(subjectrows,columnid4)=repmat({fileinfo{7}},144,1);  
            % Load file
            load(files(f).name);
            alltrialdata=final.data;
            % Copy columns into output file
            columnid3=find(strcmp(output(1,:),"trialN"));
            columnid10=find(strcmp(output(1,:),"switched"));
            output(subjectrows,columnid3:columnid10)=num2cell(alltrialdata);
            % Find number of accurate trials 
            correcttrials=sum(alltrialdata(:,6));
            columnid15=find(strcmp(output(1,:),"Total_Trials_Correct"));
            output(subjectrows,columnid15)=repmat(num2cell(correcttrials),length(subjectrows),1);
            % Find Mean, Median, and STD for RT
            indexcorrect=find(alltrialdata(:,6)==1);
            allmeanrt=mean(alltrialdata(indexcorrect,5));
            allmedianrt=median(alltrialdata(indexcorrect,5));
            allstdrt=std(alltrialdata(indexcorrect,5));
            columnid16=find(strcmp(output(1,:),"All_MeanRT"));
            columnid17=find(strcmp(output(1,:),"All_MedianRT"));
            columnid18=find(strcmp(output(1,:),"All_SD"));
            output(subjectrows,columnid16)=repmat(num2cell(allmedianrt),length(subjectrows),1);
            output(subjectrows,columnid17)=repmat(num2cell(allmeanrt),length(subjectrows),1);
            output(subjectrows,columnid18)=repmat(num2cell(allstdrt),length(subjectrows),1);
            
            %Find Mean, Median, and STD for RT Switch
            if strcmp(fileinfo{5},'low')
                indexshiftl=find(alltrialdata(:,8)==1 & alltrialdata(:,6)==1);
                columnid19=find(strcmp(output(1,:),"Shift_Total_Trials"));
                output(subjectrows,columnid19)=repmat(num2cell(numel(indexshiftl)),ntrials,1);
                indexnoshiftl=find(alltrialdata(:,8)==0 & alltrialdata(:,6)==1);
                columnid24=find(strcmp(output(1,:),"NoShift_Total_Trials"));
                output(subjectrows,columnid24)=repmat(num2cell(numel(indexnoshiftl)),ntrials,1);
                indexallnoshiftl=find(alltrialdata(:,8)==0);
                nsaccuracyl=(sum(alltrialdata(indexallnoshiftl,6))/(numel(indexallnoshiftl)));
                columnid25=find(strcmp(output(1,:),"NoShift_Accuracy"));
                output(subjectrows,columnid25)=repmat(num2cell(nsaccuracyl),ntrials,1);
                nsmeanrtl=mean(alltrialdata(indexnoshiftl,5));
                nsmedianrtl=median(alltrialdata(indexnoshiftl,5));
                nsstdrtl=std(alltrialdata(indexnoshiftl,5));
                columnid26=find(strcmp(output(1,:),"NoShift_MeanRT"));
                columnid27=find(strcmp(output(1,:),"NoShift_MedianRT"));
                columnid28=find(strcmp(output(1,:),"NoShift_SD"));
                output(subjectrows,columnid26)=repmat(num2cell(nsmeanrtl),length(subjectrows),1);
                output(subjectrows,columnid27)=repmat(num2cell(nsmedianrtl),length(subjectrows),1);
                output(subjectrows,columnid28)=repmat(num2cell(nsstdrtl),length(subjectrows),1);
            else
                indexshifth=find(alltrialdata(:,8)==1 & alltrialdata(:,6)==1);
                output(subjectrows,columnid19)=repmat(num2cell(numel(indexshifth)),ntrials,1);
                indexallshifth=find(alltrialdata(:,8)==1);
                saccuracy=(sum(alltrialdata(indexallshifth,6)/(numel(indexallshifth))));
                columnid20=find(strcmp(output(1,:),"Shift_Accuracy"));
                output(subjectrows,columnid20)=repmat(num2cell(saccuracy),ntrials,1);
                smeanrth=mean(alltrialdata(indexshifth,5));
                smedianrth=median(alltrialdata(indexshifth,5));
                sstdrth=std(alltrialdata(indexshifth,5));
                columnid21=find(strcmp(output(1,:),"Shift_MeanRT"));
                columnid22=find(strcmp(output(1,:),"Shift_MedianRT"));
                columnid23=find(strcmp(output(1,:),"Shift_SD"));
                output(subjectrows,columnid21)=repmat(num2cell(smeanrth),length(subjectrows),1);
                output(subjectrows,columnid22)=repmat(num2cell(smedianrth),length(subjectrows),1);
                output(subjectrows,columnid23)=repmat(num2cell(sstdrth),length(subjectrows),1);
                indexnoshifth=find(alltrialdata(:,8)==0 & alltrialdata(:,6)==1);
                output(subjectrows,columnid24)=repmat(num2cell(numel(indexnoshifth)),ntrials,1); 
                indexallnoshifth=find(alltrialdata(:,8)==0);
                nsaccuracy=(sum(alltrialdata(indexallnoshifth,6))/(numel(indexallnoshifth)));
                output(subjectrows,columnid25)=repmat(num2cell(nsaccuracy),ntrials,1);
                nsmeanrth=mean(alltrialdata(indexnoshifth,5));
                nsmedianrth=median(alltrialdata(indexnoshifth,5));
                nsstdrth=std(alltrialdata(indexnoshifth,5));
                output(subjectrows,columnid26)=repmat(num2cell(nsmeanrth),length(subjectrows),1);
                output(subjectrows,columnid27)=repmat(num2cell(nsmedianrth),length(subjectrows),1);
                output(subjectrows,columnid28)=repmat(num2cell(nsstdrth),length(subjectrows),1);
            end
            if strcmp(fileinfo{5},'low') && strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'Vertex')
                lowprevertexmedian=allmedianrt;
                lowprevertexnoshiftacc=nsaccuracyl;
            elseif strcmp(fileinfo{5},'low') && strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'Vertex')
                lowpostvertexmedian=allmedianrt;
                lowpostvertexnoshiftacc=nsaccuracyl;
            elseif strcmp(fileinfo{5},'high') && strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'Vertex')
                highprevertexmedian=allmedianrt;
                highprevertexshiftacc=saccuracy;
            elseif strcmp(fileinfo{5},'high') && strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'Vertex')
                highpostvertexmedian=allmedianrt;
                highpostvertexshiftacc=saccuracy;
            elseif strcmp(fileinfo{5},'low') && strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'FPCN-B')
                lowpreFPCNBmedian=allmedianrt;
                lowpreFPCNBnoshiftacc=nsaccuracyl;
            elseif strcmp(fileinfo{5},'low') && strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'FPCN-B')
                lowpostFPCNBmedian=allmedianrt;
                lowpostFPCNBnoshiftacc=nsaccuracyl;
            elseif strcmp(fileinfo{5},'high') && strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'FPCN-B')
                highpreFPCNBmedian=allmedianrt;
                highpreFPCNBshiftacc=saccuracy;
            elseif strcmp(fileinfo{5},'high') && strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'FPCN-B')
                highpostFPCNBmedian=allmedianrt;
                highpostFPCNBshiftacc=saccuracy;
            elseif strcmp(fileinfo{5},'low') && strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'DAN')
                lowpreDANmedian=allmedianrt;
                lowpreDANnoshiftacc=nsaccuracyl;
            elseif strcmp(fileinfo{5},'low') && strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'DAN')
                lowpostDANmedian=allmedianrt;
                lowpostDANnoshiftacc=nsaccuracyl;
            elseif strcmp(fileinfo{5},'high') && strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'DAN')
                highpreDANmedian=allmedianrt;
                highpreDANshiftacc=saccuracy;
            elseif strcmp(fileinfo{5},'high') && strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'DAN')
                highpostDANmedian=allmedianrt;
                highpostDANshiftacc=saccuracy;
            end
        end
    end
       
        if strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'Vertex')
            rows=find(strcmp(output(:,13),'pre') & strcmp(output(:,12),'Vertex') & strcmp(output(:,1),answer(i)));
            columnid29=find(strcmp(output(1,:),"Shift_cost_RT_pre"));
            columnid30=find(strcmp(output(1,:),"Shift_cost_RT_post"));
            columnid32=find(strcmp(output(1,:),"Shift_cost_Accuracy_pre"));
            columnid33=find(strcmp(output(1,:),"Shift_cost_Accuracy_post"));
            output(rows,columnid29)=repmat(num2cell(highprevertexmedian-lowprevertexmedian),ntrials*2,1);
            output(rows,columnid30)=repmat({'0'},ntrials*2,1);
            output(rows,columnid32)=repmat(num2cell(highprevertexshiftacc-lowprevertexnoshiftacc),ntrials*2,1);
            output(rows,columnid33)=repmat({'0'},ntrials*2,1);
        elseif strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'Vertex')
            rows=find(strcmp(output(:,13),'post') & strcmp(output(:,12),'Vertex') & strcmp(output(:,1),answer(i)));
            output(rows,columnid30)=repmat(num2cell(highpostvertexmedian-lowpostvertexmedian),ntrials*2,1);
            output(rows,columnid29)=repmat({'0'},ntrials*2,1);
            output(rows,columnid33)=repmat(num2cell(highpostvertexshiftacc-lowpostvertexnoshiftacc),ntrials*2,1);
            output(rows,columnid32)=repmat({'0'},ntrials*2,1);
        elseif strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'FPCN-B')
            rows=find(strcmp(output(:,13),'pre') & strcmp(output(:,12),'FPCN-B') & strcmp(output(:,1),answer(i)));
            output(rows,columnid29)=repmat(num2cell(highpreFPCNBmedian-lowpreFPCNBmedian),ntrials*2,1);
            output(rows,columnid30)=repmat({'0'},ntrials*2,1);
            output(rows,columnid32)=repmat(num2cell(highpreFPCNBshiftacc-lowpreFPCNBnoshiftacc),ntrials*2,1);
            output(rows,columnid33)=repmat({'0'},ntrials*2,1);
        elseif strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'FPCN-B')
            rows=find(strcmp(output(:,13),'post') & strcmp(output(:,12),'FPCN-B')& strcmp(output(:,1),answer(i)));
            output(rows,columnid30)=repmat(num2cell(highpostFPCNBmedian-lowpostFPCNBmedian), ntrials*2,1);
            output(rows,columnid29)=repmat({'0'},ntrials*2,1);
            output(rows,columnid33)=repmat(num2cell(highpostFPCNBshiftacc-lowpostFPCNBnoshiftacc),ntrials*2,1);
            output(rows,columnid32)=repmat({'0'},ntrials*2,1);
        elseif strcmp(fileinfo{8},'pre') && strcmp(fileinfo{9},'DAN')
            rows=find(strcmp(output(:,13),'pre') & strcmp(output(:,12),'DAN')& strcmp(output(:,1),answer(i)));
            output(rows,columnid29)=repmat(num2cell(highpreDANmedian-lowpreDANmedian),ntrials*2,1);
            output(rows,columnid30)=repmat({'0'},ntrials*2,1);
            output(rows,columnid32)=repmat(num2cell(highpreDANshiftacc-lowpreDANnoshiftacc),ntrials*2,1);
            output(rows,columnid33)=repmat({'0'},ntrials*2,1);
        elseif strcmp(fileinfo{8},'post') && strcmp(fileinfo{9},'DAN')
            rows=find(strcmp(output(:,13),'post') & strcmp(output(:,12),'DAN')& strcmp(output(:,1),answer(i)));
            output(rows,columnid30)=repmat(num2cell(highpostDANmedian-lowpostDANmedian),ntrials*2,1);
            output(rows,columnid29)=repmat({'0'},ntrials*2,1);
            output(rows,columnid33)=repmat(num2cell(highpostDANshiftacc-lowpostDANnoshiftacc),ntrials*2,1);
            output(rows,columnid32)=repmat({'0'},ntrials*2,1);
        end  
    
    subject_rows=find(strcmp(answer{i},output(:,1)) & strcmp(output(:,12),'Vertex'));
    columnid31=find(strcmp(output(1,:),"RT_changescore_shiftcost"));
    columnid34=find(strcmp(output(1,:),"Accuracy_changescore_shiftcost"));
    output(subject_rows,columnid31)=repmat(num2cell(((highpostvertexmedian-lowpostvertexmedian)-(highprevertexmedian-lowprevertexmedian))),ntrials*4,1);
    output(subject_rows,columnid34)=repmat(num2cell(((highpostvertexshiftacc-lowpostvertexnoshiftacc)-(highprevertexshiftacc-lowprevertexnoshiftacc))),(ntrials*4),1);
    subject_rows=find(strcmp(answer{i},output(:,1)) & strcmp(output(:,12),'FPCN-B'));
    output(subject_rows,columnid31)=repmat(num2cell(((highpostFPCNBmedian-lowpostFPCNBmedian)-(highpreFPCNBmedian-lowpreFPCNBmedian))),ntrials*4,1);
    output(subject_rows,columnid34)=repmat(num2cell(((highpostFPCNBshiftacc-lowpostFPCNBnoshiftacc)-(highpreFPCNBshiftacc-lowpreFPCNBnoshiftacc))),(ntrials*4),1);
    subject_rows=find(strcmp(answer{i},output(:,1)) & strcmp(output(:,12),'DAN'));
    output(subject_rows,columnid31)=repmat(num2cell(((highpostDANmedian-lowpostDANmedian)-(highpreDANmedian-lowpreDANmedian))),ntrials*4,1);
    output(subject_rows,columnid34)=repmat(num2cell(((highpostDANshiftacc-lowpostDANnoshiftacc)-(highpreDANshiftacc-lowpreDANnoshiftacc))),(ntrials*4),1);
end


finalfilename='Navon_Behavioral_LongFormat_PRISM.xlsx';
writecell(output,finalfilename);