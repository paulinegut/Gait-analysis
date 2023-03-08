
function concS = concentrateMats(source, files)

concS = struct ([]);

% Initialize cell for storing valid field names
validFieldNames = cell(length(files),1);

% Transfer data from all single trials to a new, concentrated matrix
% which contains all trials

% Iterate over single trial data
for nFiles = 1:length(files)
    % Load trial data
    load(fullfile(source, files{nFiles}),'S');
    openFields = fieldnames(S);
    
    % Obtain subparts of filename
    tempNames = strsplit(files{nFiles},'_');    % Parse filename
    % Remove subject part to generate valid variable name
    for ii = 2:length(tempNames)
        validFieldNames{nFiles} = strcat(validFieldNames{nFiles}, tempNames{ii}, '_');
    end
    validFieldNames{nFiles} = validFieldNames{nFiles}(1:end-5);
    
    for nField = 1:length(openFields)
        concS(1).(openFields{nField}).(validFieldNames{nFiles}) = S.(openFields{nField}) ;
    end
end

%% Make new step fields that include data from all steps in a give condition

% Transfer data from the original R and L fields to the new ones which have
%data from R and L from all steps (first one)
concS.Rtrue = [concS.R.(validFieldNames{1})];
concS.Ltrue = [concS.L.(validFieldNames{1})];

% Determine how many steps in R and L are being added to the new fields (first one)
blockSizeR = size(concS.R.(validFieldNames{1}),2);
blockSizeL = size(concS.L.(validFieldNames{1}),2);

% Add the original trial names to a matrix of cells which will later be
% added to the new fields (first one)
origTrialNamesR = repmat(validFieldNames(1), blockSizeR, 1);
origTrialNamesL = repmat(validFieldNames(1), blockSizeL, 1);

% Repeat this process for all other trials adding their data to the new
% field
for nFiles = 2:length(files)
    
    % Determine how many steps in R and L are being added to the new fields
    blockSizeR = size(concS.R.(validFieldNames{nFiles}),2);
    blockSizeL = size(concS.L.(validFieldNames{nFiles}),2);
    
    % Transfer data from the original R and L fields to the new ones which have
    %data from R and L from all steps
    concS.Rtrue(end+1:end+blockSizeR) = [concS.R.(validFieldNames{nFiles})];
    concS.Ltrue(end+1:end+blockSizeL) = [concS.L.(validFieldNames{nFiles})];
    
    % Add the original trial names to a matrix of celsl which will later be
    % added to the new fields
    origTrialNamesR = [origTrialNamesR; repmat(validFieldNames(nFiles), blockSizeR, 1)];
    origTrialNamesL = [origTrialNamesL; repmat(validFieldNames(nFiles), blockSizeL, 1)];
    
end

% Add the matrix of cell names to the new fields so that we know which step
% each trial belongs to
for iOrigTrialName = 1:length(origTrialNamesR)
    [concS.Rtrue(iOrigTrialName).originalTrialName]=origTrialNamesR(iOrigTrialName);
end
for iOrigTrialName = 1:length(origTrialNamesL)
    [concS.Ltrue(iOrigTrialName).originalTrialName]=origTrialNamesL(iOrigTrialName);
end

% Replace the original fields with the new, concentrated ones
concS.R = concS.Rtrue;
concS.L = concS.Ltrue;

concS = rmfield(concS, 'Rtrue');
concS = rmfield(concS, 'Ltrue');

% Save the concentrated structure
saveConcMat(source, concS)

end

function saveConcMat(source, concS) 

% Get output folder name
[~,structName,~] = fileparts(source);
% Assign concentrated data to struct with output folder as field name
S.(structName) = concS;
% Save fields from struct as single variables (-struct) as .mat-file
save(['conc' structName '.mat'], '-struct', 'S')

end

