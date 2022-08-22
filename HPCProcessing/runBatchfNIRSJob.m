function runBatchfNIRSJob(nslots)

addpath(genpath('/usr3/graduate/mhn/Documents/ResearchProjects/spatailAttentionProject/'));
addpath(genpath('/projectnb2/binaural/mhn/RawDatafNIRS/'));

% Parallel processing for BU's SCC
myCluster = parcluster('local'); % cores on compute node to be "local"
if getenv('ENVIRONMENT')    % true if this is a batch job
  myCluster.JobStorageLocation = getenv('TMPDIR')  % points to TMPDIR
end

parpool(myCluster, nslots)

sbjList = {'08'};
parfor i = 1:length(sbjList)
    sbjNum = sbjList{i};
    rawDataDir = ['/projectnb2/binaural/mhn/RawDatafNIRS/Experiment' num2str(sbjNum)];
    loadS = load([rawDataDir filesep num2str(sbjNum)],'s');
    preprocessFNIRS06_CV_GLM_ssBeta(s,2,1,1);
    preprocessFNIRS06_CV_GLM_ssBeta(s,3,1,1);
    %createSingleTrialHRF_SSBeta(s.name,s.movieList,2);
    %calcCumSum_DiffStartT_AllChn_CompClassifiers_Final(s.name,2,1);
    close all;
end

sbjList = {'12','13','14','15','16','19','21','22','23'};
parfor i = 1:length(sbjList)
    sbjNum = sbjList{i};
    rawDataDir = ['/projectnb2/binaural/mhn/RawDatafNIRS/Experiment' num2str(sbjNum)];
    loadS = load([rawDataDir filesep num2str(sbjNum)],'s');
    preprocessFNIRS06_CV_GLM_ssBeta_MultiOnly(s,2,1,1);
    preprocessFNIRS06_CV_GLM_ssBeta_MultiOnly(s,3,1,1);
    %createSingleTrialHRF_SSBeta(s.name,s.movieList,2);
    %calcCumSum_DiffStartT_AllChn_CompClassifiers_Final(s.name,2,1);
    close all;
end

delete(gcp) 

end