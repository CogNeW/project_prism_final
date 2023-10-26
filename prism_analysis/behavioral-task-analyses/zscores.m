%% Z scores sheet
% By Julia Dengler
% This code reads in long format sheets and removes subjects who have
% median accuracies over or equal to two standard deviations away from the
% mean using z scores in the pre condition. The subject is then removed
% from the long sheet and outputted into a new excel sheet. The code will
% also output the subjects who meet the removal criteria. This code can run
% both Navon and Stroop long format sheets and can easily be adjusted for
% n-back and others. 

%% Navon
[num,txt,output]=xlsread('Navon_Behavioral_LongFormat_PRISM_final_x2.xlsx');
% Stroop
%[snum,stxt,soutput]=xlsread('Navon_Behavioral_LongFormat_Randeffects_hl.xlsx');
%% Filter out all post data
prenavon=strcmp(output(2:end,14),'pre');
newout=output(prenavon,:);
newout=newout(2:end,:);

%prestroop=strcmp(soutput(2:end,13),'Pre');
%snewout=output(prestroop,:);
%snewout=snewout(2:end,:);

%% For each subject find median accuracy (i guess find accuracy for low and then high and then take the median)
subjectnumsnavon=string(unique(newout(:,1)));
%subjectnumsstroop=string(unique(cell2mat(snewout(:,1))));
for i=1:length(subjectnumsnavon)
    indxhighver=find(strcmp(newout(:,11),'high') & strcmp(string(cell2mat(newout(:,1))), subjectnumsnavon(i)) & strcmp(newout(:,13),'Vertex'));
    indxhighfpcnb=find(strcmp(newout(:,11),'high') & strcmp(string(cell2mat(newout(:,1))), subjectnumsnavon(i)) & strcmp(newout(:,13),'FPCN-B'));
    indxhighdan=find(strcmp(newout(:,11),'high') & strcmp(string(cell2mat(newout(:,1))), subjectnumsnavon(i)) & strcmp(newout(:,13),'DAN'));
    accuracyhighver(i,1)=(sum(cell2mat(newout(indxhighver,8))))/144;
    accuracyhighfpcnb(i,1)=(sum(cell2mat(newout(indxhighfpcnb,8))))/144;
    accuracyhighdan(i,1)=(sum(cell2mat(newout(indxhighdan,8))))/144;
    indxlowver=find(strcmp(newout(:,11),'low') & strcmp(string(cell2mat(newout(:,1))), subjectnumsnavon(i)) & strcmp(newout(:,13),'Vertex'));
    indxlowfpcnb=find(strcmp(newout(:,11),'low') & strcmp(string(cell2mat(newout(:,1))), subjectnumsnavon(i)) & strcmp(newout(:,13),'FPCN-B'));
    indxlowdan=find(strcmp(newout(:,11),'low') & strcmp(string(cell2mat(newout(:,1))), subjectnumsnavon(i)) & strcmp(newout(:,13),'DAN'));
    accuracylowver(i,1)=(sum(cell2mat(newout(indxlowver,8))))/144;
    accuracylowfpcnb(i,1)=(sum(cell2mat(newout(indxlowfpcnb,8))))/144;
    accuracylowdan(i,1)=(sum(cell2mat(newout(indxlowdan,8))))/144;
end

% for i=1:length(subjectnumsstroop)
%     indxlow=strcmp(newout(:,10),'high') & strcmp(string(cell2mat(snewout(:,1))), subjectnumsstroop(i));
%     saccuracyhigh(i,:)=(sum(cell2mat(snewout(indxhigh,7))))/216;
%     indxlow=strcmp(newout(:,10),'low') & strcmp(string(cell2mat(snewout(:,1))), subjectnumsstroop(i));
%     saccuracylow(i,:)=(sum(cell2mat(snewout(indxlow,7))))/216;
% end

    totalver=[accuracylowver, accuracyhighver];
    totalfpcnb=[accuracylowfpcnb, accuracyhighfpcnb];
    totaldan=[accuracylowdan, accuracyhighdan];
    %stotal=[saccuracylow, saccuracyhigh];
    mednavonver=median(totalver,2);
    mednavonfpcnb=median(totalfpcnb,2);
    mednavonfpcnb(isnan(mednavonfpcnb))=0;
    mednavondan=median(totaldan,2);
    %medstroop=median(stotal,2);
        
%% Create two column row that has subject ID in one and median accuracy in other
navonmed = [subjectnumsnavon, mednavonver, mednavonfpcnb, mednavondan];
%% Create z-scores and pull out any subject that is over two standard deviations away
zscoresnavon=str2double([subjectnumsnavon, zscore(mednavonver), zscore(mednavonfpcnb), zscore(mednavondan)]);
%zscoresstroop=[subjectnumsstroop, zscore(medstroop)];

%% Plot
figure(1)
combined=[zscore(mednavonver), zscore(mednavonfpcnb), zscore(mednavondan)];
numbers=1:length(subjectnumsnavon);
bar(numbers,combined, 'grouped')
% figure(2)
% bar(str2double(subjectnumsstroop), zscore(medstroop))

%% Output which subjects are > 2 std away (aka z_score > 2 or < -2)
stdindxnavonver= find(zscoresnavon(:,2) >= 2 | zscoresnavon(:,2) <= -2);
stdindxnavonfpcnb= find(zscoresnavon(:,3) >= 2 | zscoresnavon(:,3) <= -2);
stdindxnavondan= find(zscoresnavon(:,4) >= 2 | zscoresnavon(:,4) <= -2);
% stdindxstroop = find(zscoresstroop(:,2) >=2 | zscoresstroop(:,2) <= -2);

subjidsnavonver=(subjectnumsnavon(stdindxnavonver,1));
subjidsnavonfpcnb=(subjectnumsnavon(stdindxnavonfpcnb,1));
subjidsnavondan=(subjectnumsnavon(stdindxnavondan,1));
% subjidsstroop=num2cell(zscoresstroop(stdindxstroop,1));

disp('Navon:')
disp(subjidsnavonver)
disp(subjidsnavonfpcnb) 
disp(subjidsnavondan)
% disp('Stroop:')
% disp(subjidsstroop)

%% Remove these rows from the excel sheet
for i=1:length(subjidsnavonver)
    rmindx=strcmp(output(:,1),subjidsnavonver(i)) & strcmp(output(:,13),'Vertex');
    output(rmindx,:) = [];
end
for i=1:length(subjidsnavonfpcnb)
    rmindx=strcmp(output(:,1),subjidsnavonfpcnb(i)) & strcmp(output(:,13),'FPCN-B');
    output(rmindx,:) = [];
end
for i=1:length(subjidsnavondan)
    rmindx=strcmp(output(:,1),subjidsnavondan(i)) & strcmp(output(:,13),'DAN');
    output(rmindx,:) = [];
end

% for i=1:length(subjidsstroop)
%     rmindx=(find((cell2mat(soutput(2:end,1))) == (cell2mat(subjidsstroop(i)))))+1;
%     soutput(rmindx, :) = [];
% end

% Write to excel sheets
finalfilename='Navon_Behavioral_LongFormat_PRISM_final_x2_z.xlsx';
writecell(output,finalfilename);
% 
% finalfilename='Stroop_Behavioral_LongFormat_Randeffects_hl_z.xlsx';
% writecell(soutput,finalfilename);