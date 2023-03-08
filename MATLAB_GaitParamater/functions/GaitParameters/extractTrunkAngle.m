% Extracts trunk inclination angle of gait cycle phases from
% marker and event data
function [S] =  extractTrunkAngle(S)

%for every left step
for iStep = 1 : length(S.L)
    S.L(iStep).inclinationAngle = inclinationAngle(S.L(iStep).points);
    
    % For plotting
    %         subplot(2,1,1)
    %         plot(S.L(iStep).inclinationAngle)
    %         subplot(2,1,2)
    %         for ii = 1:length(S.L(iStep).points.RASI)/20:length(S.L(iStep).points.RASI)
    %             midPel = (S.L(iStep).points.LASI+S.L(iStep).points.RASI+S.L(iStep).points.LPSI+S.L(iStep).points.RPSI)/4;
    %             midThx = (S.L(iStep).points.C7+S.L(iStep).points.T10+S.L(iStep).points.STRN+S.L(iStep).points.CLAV)/4;
    %             line([midPel(round(ii),2) midThx(round(ii),2)],[midPel(round(ii),3) midThx(round(ii),3)]);
    %         end
    %         axis equal
    %         pause
end

%for every right step
for iStep = 1 : length(S.R)
    S.R(iStep).inclinationAngle = inclinationAngle(S.R(iStep).points);
    
    % For plotting
    %         subplot(2,1,1)
    %         plot(S.R(iStep).inclinationAngle)
    %         subplot(2,1,2)
    %         for ii = 1:length(S.R(iStep).points.RASI)/20:length(S.R(iStep).points.RASI)
    %             midPel = (S.R(iStep).points.LASI+S.R(iStep).points.RASI+S.R(iStep).points.LPSI+S.R(iStep).points.RPSI)/4;
    %             midThx = (S.R(iStep).points.C7+S.R(iStep).points.T10+S.R(iStep).points.STRN+S.R(iStep).points.CLAV)/4;
    %             line([midPel(round(ii),2) midThx(round(ii),2)],[midPel(round(ii),3) midThx(round(ii),3)]);
    %         end
    %         pause
end

end


function thoraxAngle = inclinationAngle(points)

% Check if all marker positions for trunk inclination angle exist
if(isfield(points, 'RASI') && isfield(points, 'LASI') && ...
        isfield(points, 'RPSI') && isfield(points, 'LPSI') && ...
        isfield(points, 'C7') && isfield(points, 'T10') && ...
        isfield(points, 'STRN') && isfield(points, 'CLAV'))
    
    try
        % Obtain virtual mid-pelvis marker
        midPelvis = (points.RASI + points.LASI + points.LPSI + points.RPSI)/4;% mid point of pelvis
        % Obtain virtual mid-thorax marker
        midThorax = (points.CLAV + points.C7 + points.STRN + points.T10)/4;
        % Obtain thorax inclination vector
        incVec = midThorax - midPelvis;
        % Project thorax inclination vector to sagittal plane (has to be the forward direction)
        incVecSagittal = incVec;
        incVecSagittal(:,1) = 0;
        
        % Take vertical vector (z-axis) as reference
        verVec = repmat([0 0 1],length(incVecSagittal),1);
        % Calculate thorax angle using arc tangens and the cross and
        % dot product between reference axis and trunk inclination angle
        crossVec = cross(incVecSagittal,verVec,2);
        dotVec = dot(incVecSagittal,verVec,2);
        normVec = cellfun(@norm,num2cell(crossVec,2));
        thoraxAngle = sign(incVecSagittal(:,2)).*atan2d(normVec, dotVec);
    catch
        disp('Error in calculation.');
        thoraxAngle = 0;
    end
else
    thoraxAngle = 0;
end
end
