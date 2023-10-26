%% This code was used to make the randomization of tasks for each subject 
% for the PRISM pilot study. Press run and click on rand_matrix to get a
% list of more subjects if needed (to add to orginal list). Ask Julia if
% you have any questions. 

num_subjects=72;
%% Generate Random Strings for each subject
% If we want lowercase 
% s='abcdefghijklmnopqrstuvwxyz';
% If we want uppercase
 
for i=1:num_subjects 
    s='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    %find number of characters to chose from 
    numrands = length(s); 
    %length of string wanted
    slength = 3;
    %generate random string
    randstring = s( ceil(rand(1,slength)*numrands) );
    %create subject ID
    rand_matrix(i*3:(i*3+2),1)=convertCharsToStrings(append('P_',randstring));
end

rand_matrix=rand_matrix(3:end,:);
%% Find session number
rand_matrix(:,2)=repmat([1;2;3],72,1);

%% Find targets
for j=1:(num_subjects/6)
    target={'Vertex' 'FPCN-B' 'DAN'};
    permtarget={'123' '132' '213' '231' '312' '321'};
    randtarget=randperm(numel(permtarget))';
    for i=1:length(permtarget)
        tindex(1,i)=permtarget(randtarget(i,1));
    end
    
    targetindex=num2str(cell2mat(tindex));
        for k=1:18
            rand_matrix(k+18*(j-1),3)=target(1,str2double(targetindex(1,k)));
        end
end

%% Find color
rand_matrix(:,4)=repmat(['g';'g';'g';'w';'w';'w'],36,1);

%% Find Low Navon Prac randomization
for j=1:(num_subjects/6)
    target={'prac' 'prac1' 'prac2'};
    permtarget={'123' '132' '213' '231' '312' '321'};
    randtarget=randperm(numel(permtarget))';
    for i=1:length(permtarget)
        tindex(1,i)=permtarget(randtarget(i,1));
    end
    
    targetindex=num2str(cell2mat(tindex));
        for k=1:18
            rand_matrix(k+18*(j-1),5)=target(1,str2double(targetindex(1,k)));
        end
end
%% Find High Navon Prac randomization
for j=1:(num_subjects/6)
    target={'prac' 'prac1' 'prac2'};
    permtarget={'123' '132' '213' '231' '312' '321'};
    randtarget=randperm(numel(permtarget))';
    for i=1:length(permtarget)
        tindex(1,i)=permtarget(randtarget(i,1));
    end
    
    targetindex=num2str(cell2mat(tindex));
        for k=1:18
            rand_matrix(k+18*(j-1),6)=target(1,str2double(targetindex(1,k)));
        end
end
%% Find Low Navon randomization
for i=1:num_subjects
    low_navon={'expA' 'expB' 'expC' 'expD' 'expE' 'expF'};
    randlownavon=randperm(numel(low_navon));
    rand_matrix((i-1)*3+1:(i-1)*3+3,7)=low_navon(randlownavon(:,4:6));
    rand_matrix((i-1)*3+1:(i-1)*3+3,9)=low_navon(randlownavon(:,1:3));
end

%% Find High Navon randomization
for i=1:num_subjects
    high_navon={'expA' 'expB' 'expC' 'expD' 'expE' 'expF'};
    randhighnavon=randperm(numel(high_navon));
    rand_matrix((i-1)*3+1:(i-1)*3+3,8)=high_navon(randhighnavon(:,4:6));
    rand_matrix((i-1)*3+1:(i-1)*3+3,10)=high_navon(randhighnavon(:,1:3));
end

%% Find n-back randomization
for j=1:(num_subjects/6)
    target=[1 2 3];
    permtarget={'123' '132' '213' '231' '312' '321'};
    randtarget=randperm(numel(permtarget))';
    for i=1:length(permtarget)
        tindex(1,i)=permtarget(randtarget(i,1));
    end
    
    targetindex=num2str(cell2mat(tindex));
        for k=1:18
            rand_matrix(k+18*(j-1),11)=target(1,str2double(targetindex(1,k)));
        end
end

for i=1:num_subjects
    nback=[1 2 3 4 5 6];
    randnback=randperm(numel(nback));
    rand_matrix((i-1)*3+1:(i-1)*3+3,12)=nback(randnback(:,1:3));
    rand_matrix((i-1)*3+1:(i-1)*3+3,13)=nback(randnback(:,4:6));
end
    
%% Find Low Stroop Prac
for j=1:(num_subjects/6)
    target={'prac' 'prac1' 'prac2'};
    permtarget={'123' '132' '213' '231' '312' '321'};
    randtarget=randperm(numel(permtarget))';
    for i=1:length(permtarget)
        tindex(1,i)=permtarget(randtarget(i,1));
    end
    
    targetindex=num2str(cell2mat(tindex));
        for k=1:18
            rand_matrix(k+18*(j-1),14)=target(1,str2double(targetindex(1,k)));
        end
end
%% Find High Stroop Prac
for j=1:(num_subjects/6)
    target={'prac' 'prac1' 'prac2'};
    permtarget={'123' '132' '213' '231' '312' '321'};
    randtarget=randperm(numel(permtarget))';
    for i=1:length(permtarget)
        tindex(1,i)=permtarget(randtarget(i,1));
    end
    
    targetindex=num2str(cell2mat(tindex));
        for k=1:18
            rand_matrix(k+18*(j-1),15)=target(1,str2double(targetindex(1,k)));
        end
end
%% Find Low Stroop randomization
for i=1:num_subjects
    low_stroop={'expA' 'expB' 'expC' 'expD' 'expE' 'expF'};
    randlowstroop=randperm(numel(low_stroop));
    rand_matrix((i-1)*3+1:(i-1)*3+3,16)=low_stroop(randlowstroop(:,4:6));
    rand_matrix((i-1)*3+1:(i-1)*3+3,18)=low_stroop(randlowstroop(:,1:3));
end

%% Find High Stroop randomization
for i=1:num_subjects
    high_stroop={'expA' 'expB' 'expC' 'expD' 'expE' 'expF'};
    randhighstroop=randperm(numel(high_stroop));
    rand_matrix((i-1)*3+1:(i-1)*3+3,17)=high_stroop(randhighstroop(:,4:6));
    rand_matrix((i-1)*3+1:(i-1)*3+3,19)=high_stroop(randhighstroop(:,1:3));
end

%% Add a header
header={'Subject ID', 'Session', 'Target', 'First Color', 'Navon Prac Low','Navon Prac High', 'Navon Pre Low', 'Navon Pre High', 'Navon Post Low', 'Navon Post High','n-back Prac', 'n-back Pre', 'n-back Post', 'Stroop Prac Low', 'Stroop Prac High', 'Stroop Pre Low', 'Stroop Pre High', 'Stroop Post Low', 'Stroop Post High'};
rand_matrix=[header; rand_matrix];
