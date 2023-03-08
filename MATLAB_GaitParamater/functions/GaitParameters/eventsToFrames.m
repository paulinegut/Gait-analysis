function S = eventsToFrames (S)
%EventsToFrames Converts events in seconds to frames
% Converts Nexus events stored in seconds to frames using the sampling
% frequency and correcting for cut trials

fields = fieldnames (S.evts);
for i = 1: length(fields)
    % Change events from seconds to frames
    % currentTime = (currentFrame - 1)*1/pointFq
    % currentFrame = Time*pointFq + 1
    % Events are relative to 1st frame of original recording even after cutting
    % Remove therefore (firstFrame - 1) to always start trials with frame 1
    S.evts.(fields{i}) = round((S.evts.(fields{i}) * S.stats.pointFq + 1) - (S.stats.firstFrame - 1),0);
       
    % Inserted check for events that are outside of the crop. These are now
    % removed and the error logged
    if max(S.evts.(fields{i})) > S.stats.lastFrame
        S.errors(end+1) = {[fields{i} ' : out of bounds events (after crop) detected and removed.. No Mercy.']}; % count the false steps
        S.evts.(fields{i}) = S.evts.(fields{i}) (S.evts.(fields{i}) < S.stats.lastFrame);
    end
    if min(S.evts.(fields{i})) < 1
        S.errors(end+1) = {[fields{i} ' : Events before your crop detected and removed.. No Mercy.']}; % count the false steps
        S.evts.(fields{i}) = S.evts.(fields{i}) (S.evts.(fields{i}) > 0);
    end  
end
end